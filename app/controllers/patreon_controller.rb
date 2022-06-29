class PatreonController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /patreon/authenticate
  def authenticate
    client_id = Rails.application.credentials.patreon[:client_id]
    client_secret = Rails.application.credentials.patreon[:client_secret]

    # replace above in development and add keys to .env
    # client_id = ENV["PATREON_CLIENT_ID"]
    # client_secret = ENV["PATREON_CLIENT_SECRET"]

    oauth_client = Patreon::OAuth.new(client_id, client_secret)
    tokens = oauth_client.get_tokens(params[:code], params[:redirect_uri])
    @access_token = tokens['access_token']
    @user = get_user(@access_token)
    render json: { errors: "user not found"}, status: 401 unless @user
    @is_member = is_member(@user) if @user
  end

  # get patron user [access_token]
  def user
    @user = get_user(params[:access_token])
    render json: { error: "user not found" }, status: 401 unless @user
    @is_member = is_member(@user) if @user
  end

  private

    def is_member(user)
      is_daddy(user) || is_subscriber(user)
    end

    def is_daddy(user)
      Daddy.exists?(email: user.email)
    end

    def is_subscriber(user)
      patreon_tiers = ["Member", "Full Membership", "Soundstream Membership", "Artist Support Fund Membership", "Catalytic Full Membership"]

      user.pledges.any? do |pledge|
        pledge.creator.campaign.name == "Catalytic Sound" && pledge.reward.title.in?(patreon_tiers)
      end
    end

    def get_user(access_token)
      api_client = init_client(access_token)
      user_response = api_client.fetch_user()
      # user_response uses [json-api-vanilla](https://github.com/trainline/json-api-vanilla) for easy usage
      user_response.data
    end

    def init_client(access_token)
      Patreon::API.new(access_token)
    end

    def auth_params
      params.require(:patreon).permit(:code, :access_token, :redirect_uri)
    end
end

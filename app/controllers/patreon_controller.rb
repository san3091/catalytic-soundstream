class PatreonController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized

  # POST /patreon/authenticate
  def authenticate
    client_id = Rails.application.credentials.patreon[:client_id]
    client_secret = Rails.application.credentials.patreon[:client_secret]
    redirect_uri = "https://27d8beebdd79.ngrok.io"

    oauth_client = Patreon::OAuth.new(client_id, client_secret)
    tokens = oauth_client.get_tokens(params[:code], redirect_uri)
    @access_token = tokens['access_token']
    @user = get_user(@access_token)
    @is_member = is_member(@user)
  end

  # get patron user [access_token]
  def user
    @user = get_user(params[:access_token])
    render json: { error: "not found" }, status: 404 unless @user
    @is_member = is_member(@user) if @user
  end

  private

    def is_member(user)
      user.pledges.any? { |pledge| pledge.creator.campaign.name == "Catalytic Sound" && pledge.reward.title == "Member" || Daddy.exists?(email: user.email) }
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
      params.require(:patreon).permit(:Hcode, :access_token)
    end

end

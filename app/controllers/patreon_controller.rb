class PatreonController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /patreon/authenticate
  def authenticate
    client_id = ENV["PATREON_CLIENT_ID"]
    client_secret = ENV["PATREON_CLIENT_SECRET"]
    redirect_uri = ENV["PATREON_REDIRECT"]

    oauth_client = Patreon::OAuth.new(client_id, client_secret)
    logger.debug("redirect uri: #{redirect_uri}")
    tokens = oauth_client.get_tokens(params[:code], redirect_uri)
    logger.debug("tokens: #{tokens} ")
    @access_token = tokens['access_token']
    logger.debug("access_tokens: #{@access_token}")
    @user = get_user(@access_token)
    logger.debug("user: #{@user}")
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
      Daddy.exists?(email: user.email) || user.pledges.any? { |pledge| pledge.creator.campaign.name == "Catalytic Sound" && pledge.reward.title == "Member" }
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

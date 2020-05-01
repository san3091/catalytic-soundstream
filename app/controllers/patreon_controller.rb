class PatreonController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /patreon/authenticate
  def authenticate
    puts params
    client_id = Rails.application.credentials.patreon[:client_id]
    client_secret = Rails.application.credentials.patreon[:client_secret]
    redirect_uri = "https://762a34aa.ngrok.io"

    oauth_client = Patreon::OAuth.new(client_id, client_secret)
    tokens = oauth_client.get_tokens(auth_params[:code], redirect_uri)
    access_token = tokens['access_token']
    @user = get_user(access_token)
    is_member = @user.pledges.any? { |pledge| pledge.creator.campaign.name == "Catalytic Sound" && pledge.reward.title == "Member" }

    if is_member
      @user
    else
      render status: :forbidden
    end

  end

  # get patron user [access_token]
  def user
    api_client = init_client(auth_params[:access_token])
  end

  private

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
      params.require(:patreon).permit(:code, :access_token)
    end

end

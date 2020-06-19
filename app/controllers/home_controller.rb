class HomeController < ApplicationController

  def index
    @init_props = {
      patreonRedirect: ENV['PATREON_REDIRECT'],
      patreonClientId: ENV['PATREON_CLIENT_ID']
    }
  end
end

class AdminSessionsController < ApplicationController
  layout "admin"

  def new
  end

  def create
    @admin = Admin.find_by(email: params[:email])

    if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to "/admin"
    else
      redirect_to '/login'
    end
  end
end

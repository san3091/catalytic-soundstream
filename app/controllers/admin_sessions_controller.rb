class AdminSessionsController < ApplicationController
  def new
  end

  def create
    @admin = Admin.find_by(email: params[:email])

    if @admin && @admin.authenticate(params[:password])
      sessions[:admin_id] = @admin.id
      redirect_to "/"
    else
      redirect_to '/login'
    end
  end
end

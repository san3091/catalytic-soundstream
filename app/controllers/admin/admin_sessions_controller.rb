class Admin::AdminSessionsController < AdminController
  layout "admin"
  before_action :authorized, only: [:delete]

  def new
  end

  def create
    @admin = Admin.find_by(email: params[:email])

    if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to "/admin"
    else
      redirect_to '/admin/login', notice: "Authentication failed"
    end
  end

  def delete
    session[:admin_id] = nil
    redirect_to "/admin/login"
  end
end

class Admin::AdminDashboardsController < AdminController
  layout "admin"

  def index
    @categories = Category.all
  end

  # post update category name, csv file
  def update
    category = Category.find_by(name: params[:category])
    result = category.import_albums(params[:file], params[:insert_mode])
    redirect_to '/admin', notice: "Succes! #{category.name} category updated."
  end

end

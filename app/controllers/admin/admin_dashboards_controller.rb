class Admin::AdminDashboardsController < AdminController
  layout "admin"

  def index
    @categories = Category.all
  end

  # post update category name, csv file
  def update
    category = Category.find_by(name: params[:category])
    result = category.import_albums(params[:file])
    redirect_to '/admin', notice: "Succes! #{category.name} category updated."
  rescue => e
    logger.error [e.message, *e.backtrace].join($/)
    redirect_to '/admin', notice: "There was an error updating the category. #{e.message}"
  end

end

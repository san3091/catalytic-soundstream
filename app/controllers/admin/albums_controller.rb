class Admin::AlbumsController < AdminController
  layout "admin"

  def index
    @albums_by_category = Category.includes(:albums).all
  end
end

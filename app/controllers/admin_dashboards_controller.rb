class AdminDashboardsController < ApplicationController
  layout "admin"

  before_action :authorized

  def index
    @categories = Category.all
  end

  # post update category name, csv file
  def update
    category = Category.find_by(name: params[:category])
    result = category.import_albums(params[:file], params[:insert_mode])
    redirect_to '/admin', notice: "Succes! #{result.ids.length} albums added to the #{category.name} category."
  end

end

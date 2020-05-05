class AdminDashboardsController < ApplicationController
  layout "admin"

  before_action :authorized

  def index
    @categories = Category.all
  end

  # post update category name, csv file
  def update
    category = Category.find_by(name: params[:category])
    category.import_albums(params[:file])
  end

end

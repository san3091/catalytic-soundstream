class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorized
  skip_before_action :verify_authenticity_token

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.includes(:albums).order('albums.order')
  end

end

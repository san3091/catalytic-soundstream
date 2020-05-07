class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorized
  skip_before_action :verify_authenticity_token

  # GET /categories
  # GET /categories.json
  def index
    # I think this is ordering categories by album order and not the albums under the category
    @categories = Category.includes(:albums)
  end

end

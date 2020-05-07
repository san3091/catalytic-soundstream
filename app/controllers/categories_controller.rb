class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authorized

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.order(:order)
  end

end

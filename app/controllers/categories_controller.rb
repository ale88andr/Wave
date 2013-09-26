class CategoriesController < ApplicationController
  def index
  end

  def show
  	@category = Category.includes(:entities).find_by_id(params[:id])
  end
end

class CategoriesController < ApplicationController
  def index
  end

  def show
  	@category = Category.get_products_category_by_option(params[:option], params[:page]).find_by_id(params[:id])
  	# to do: need fixing
  	@category ||= Category.find_by_id(params[:id])
  end
end

class CategoriesController < ApplicationController
  def index
  end

  def show
  	@presenter = Categories::IndexPresenter.new(params)
  end
end
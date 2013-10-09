class ManufacturersController < ApplicationController
  def index
    @presenter = Manufacturers::IndexPresenter.new(params[:category_id])
  end

  def show
  end
end
class TechnologiesController < ApplicationController
  def index
    @technologies = Technology.category_technologies(params[:category_id])
  end

  def show
  end
end
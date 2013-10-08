class EntitiesController < ApplicationController
  def show
  	@entity = Entity.find_by_id(params[:id])
  	# couter
  	# @entity.increment! :views
  end
end
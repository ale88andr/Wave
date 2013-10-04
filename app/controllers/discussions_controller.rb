class DiscussionsController < ApplicationController

  def create
    @result = Discussion.create_entity_discussion_by_user(current_user, params[:entity_id], params[:discussion])
    redirect_to category_entity_path(params[:category_id], params[:entity_id]), notice: @result
  end
  
end
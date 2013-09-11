class Backend::EntitiesController < Backend::ApplicationController
  def new
    @entity = Entity.new
  end
end
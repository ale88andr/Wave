class Backend::EntityCategoriesController < Backend::ApplicationController
  def index
    @categories = EntityCategory.all
  end

  def new
    @category = EntityCategory.new
    @categories = EntityCategory.all
  end
end
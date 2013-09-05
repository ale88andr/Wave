class Backend::EntityCategoriesController < Backend::ApplicationController
	before_filter :get_all_categories, only: [:index, :new]

  def index 
  end

  def new
    @category = EntityCategory.new
  end

  def create
  	@category = EntityCategory.new(params[:entity_category])
  	if @category.save
  		redirect_to backend_category_index_path, notice: "Категория #{@category.name} успешно созданна"
  	else
  		get_all_categories
  		render "new"
  		flash[:error] = "Категория не созданна!"
  	end
  end

  def destroy
  	@category = EntityCategory.find(params[:id])
  	@category.destroy
  	redirect_to backend_category_index_path
  end

  private

  	def get_all_categories
  		@categories = EntityCategory.all
  	end

end
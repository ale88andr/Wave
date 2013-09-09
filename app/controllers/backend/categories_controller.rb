class Backend::CategoriesController < Backend::ApplicationController

  before_filter :get_all_categories, only: [:index, :new, :edit]
  before_filter only: [:destroy, :edit, :update] { |m| m.get_category_by_id(params[:id]) }

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to backend_categories_path, notice: "Категория #{@category.name} успешно созданна"
    else
      get_all_categories
      render "new"
      flash[:error] = "Категория не созданна!"
    end
  end

  def destroy
    @category.destroy
    redirect_to backend_categories_path
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to backend_categories_path, notice: "Категория '#{@category.name}' обновленна!"
    else
      flash.now[:error] = 'Не удалось обновить категорию!'
      render :edit
    end
  end

  protected

    def get_all_categories
      @categories = Category.all
    end

    def get_category_by_id id
      @category = Category.find_by_id id      
    end

end
class Backend::CategoriesController < Backend::ApplicationController
  before_filter :get_all_categories, only: [:index, :new, :edit]

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
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to backend_categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to backend_categories_path, notice: "Категория '#{@category.name}' обновленна!"
    else
      flash.now[:error] = 'Не удалось обновить категорию!'
      render :edit
    end
  end

  private

    def get_all_categories
      @categories = Category.all
    end

end
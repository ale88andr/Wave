class Backend::EntitiesController < Backend::ApplicationController
  def new
    unless params[:entity][:category_id]
      redirect_to select_backend_entity_path, notice: 'Сначала выберите категорию!'
    else
      @category = Category.find_by_id(params[:entity][:category_id]) 
      @entity = Entity.new
      @entity.parameters.build
    end
  end

  def select
    @entity = Entity.new
  end

  def create
  	@entity = Entity.new(params[:entity])
    if @entity.save
      redirect_to backend_entity_path(@entity), notice: "Товар '#{@entity.name}' создан"
    else
      flash[:error] = "Не удалось добавить товар!"
      rener :new
    end
  end

  def show
    @entity = Entity.find_by_id(params[:id])
  end
end
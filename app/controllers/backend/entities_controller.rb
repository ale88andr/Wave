class Backend::EntitiesController < Backend::ApplicationController
  before_filter(only: [:show, :edit, :destroy, :update]) { |m| m.get_entity_by_id(params[:id]) }

  def new
    unless params.has_key?(:category_id)
      redirect_to select_backend_entities_path, notice: 'Сначала выберите категорию!'
    else
      @category = Category.find_by_id(params[:category_id])
      @entity = Entity.new
      @entity.parameters.build
    end
  end

  def select
    @entity = Entity.new
  end

  def redirect_to_new_with_category
    redirect_to new_backend_category_entity_path(category_id: params[:entity][:category_id])
  end

  def create
  	@entity = Entity.new(params[:entity])
    if @entity.save
      redirect_to backend_entity_path(@entity), notice: "Товар '#{@entity.name}' создан"
    else
      @category = @entity.category
      flash[:error] = "Не удалось добавить товар!" and render :new
    end
  end

  def show
  end

  def index
    @entities = Entity.chronology()
  end

  def edit
    @category = @entity.category
  end

  def update
    if @entity.update_attributes(params[:entity])
      redirect_to backend_entity_path @entity, notice: "Товар '#{@entity.name}' создан"
    else
      flash[:error] = "Не удалось обновить товар!" and render :edit
    end
  end

  def destroy
    @entity.destroy and redirect_to backend_entities_path, notice: "Товар удалён!"
  end

  protected
    def get_entity_by_id id
      @entity = Entity.find_by_id(id)
    end

end
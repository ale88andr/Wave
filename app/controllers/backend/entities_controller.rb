﻿class Backend::EntitiesController < Backend::ApplicationController
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
      flash[:error] = "Не удалось добавить товар!" and render :new
    end
  end

  def show
    @entity = Entity.find_by_id(params[:id])
  end

  def index
    @entities = Entity.last_by_date
  end
end
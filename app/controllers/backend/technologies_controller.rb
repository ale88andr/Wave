class Backend::TechnologiesController < Backend::ApplicationController

  before_filter only:[:edit, :update, :destroy] { |m| m.get_technology_by_id(params[:id]) }

  def new
    @technology = Technology.new
  end

  def index
    @technologies = Technology.order("name ASC").page(params[:page]).per(10)
  end

  def create
    @technology = Technology.new(params[:technology])
    if @technology.save
      redirect_to backend_technologies_path, notice: "Аттрибут '#{@technology.name}' созданн!"
    else
      flash[:error] = 'Не удалось создать аттрибут!'
      render :new
    end
  end

  def update
    if @technology.update_attributes(params[:technology])
      redirect_to backend_technologies_path, notice: "Аттрибут '#{@technology.name}' обновлен!"
    else
      flash[:error] = 'Не удалось обновить аттрибут!'
      render :edit
    end
  end

  def destroy
    @technology.destroy
    redirect_to backend_technologies_path, notice: "Аттрибут удалён"
  end

  protected

    def get_technology_by_id id
      @attribute = Technology.find(id)
    end
end
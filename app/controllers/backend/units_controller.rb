class Backend::UnitsController < Backend::ApplicationController

  before_filter(only: [:edit, :update, :destroy]) { |m| m.get_unit_by_id(params[:id]) }

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(params[:unit])
    if @unit.save
      redirect_to backend_units_path, notice: "Единица '#{@unit.param}' успешно созданна"
    else
      render "new"
      flash[:error] = "Единица измерения не созданна!"
    end
  end

  def index
    @units = Unit.all
  end

  def destroy
    @unit.destroy
    redirect_to backend_units_path, notice: 'Единица измерения удаленна!'
  end

  def edit
  end

  def update
    if @unit.update_attributes(params[:unit])
      redirect_to backend_units_path, notice: 'Единица обновленна!'
    else
      flash[:error] = "Невозможно обновить единицу #{@unit.param}"
      render :new
    end
  end

  protected

    def get_unit_by_id id
      @unit = Unit.find(id)
    end
end
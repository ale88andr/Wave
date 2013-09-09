class Backend::ManufacturersController < Backend::ApplicationController

  before_filter only:[:edit, :update, :destroy] { |m| m.find_manufacturer_by_id(params[:id]) }

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(params[:manufacturer])
    if @manufacturer.save
      redirect_to backend_manufacturers_path, notice: "Производитель '#{@manufacturer.name}' добавлен"
    else
      flash.now[:error] = 'Не удалось добавить производителя!'
      render :new
    end
  end

  def index
    @manufacturers = Manufacturer.all
  end

  def edit
  end

  def update
    if @manufacturer.update_attributes(params[:manufacturer])
      redirect_to backend_manufacturers_path, notice: "Производитель '#{@manufacturer.name}' обновлен"
    else
      flash.now[:error] = 'Не удалось обновить производителя!'
      render :edit
    end
  end

  def destroy
    @manufacturer.destroy
    redirect_to backend_manufacturers_path, notice: 'Производитель удалён!'
  end

  protected

    def find_manufacturer_by_id id
      @manufacturer = Manufacturer.find_by_id id
    end

end
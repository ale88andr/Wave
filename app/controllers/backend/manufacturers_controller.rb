class Backend::ManufacturersController < Backend::ApplicationController

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

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(params[:manufacturer])
      redirect_to backend_manufacturers_path, notice: "Производитель '#{@manufacturer.name}' обновлен"
    else
      flash.now[:error] = 'Не удалось обновить производителя!'
      render :edit
    end
  end

  def destroy
    @manufacturer = Manufacturer.find(:id)
    @manufacturer.destroy
    redirect_to backend_manufacturers_path, notice: 'Производитель удалён!'
  end

end
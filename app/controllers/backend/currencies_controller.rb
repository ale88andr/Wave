class Backend::CurrenciesController < Backend::ApplicationController

  def index
    @currencies = Currency.all
  end

  def edit
  	@currency = Currency.find(params[:id])
  end

  def update
  	@currency = Currency.find(params[:id])
  	if @currency.update_attributes(params[:currency])
  		redirect_to backend_currencies_path, notice: "Валюта обновленна"
  	else
  		render :edit and flash[:now][:error] = "Значение не обновленно"
  	end
  end

end
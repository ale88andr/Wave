class Backend::CurrenciesController < Backend::ApplicationController

  def index
    @currencies = Currency.all
  end

  def edit
  	@currency = Currency.find(params[:id])
  end

end
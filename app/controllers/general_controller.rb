class GeneralController < ApplicationController
  load_and_authorize_resource :class => false
  def index
  	@presenter = General::IndexPresenter.new
  end
end

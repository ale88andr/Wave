class Backend::ApplicationController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'backend/application'
  def current_ability
    @current_ability ||= BackendAbility.new(current_user)
  end
end
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

    def record_not_found
      render 'public/404'
    end
end

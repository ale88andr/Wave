class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

    def record_not_found
      render 'public/404', status: 404
    end

    def current_cart
      cur = session[:cart_id].nil? ? 0 : session[:cart_id]
      Cart.find(cur)
    rescue
      cart = Cart.create(user_id: current_user.id ||= 0)
      session[:cart_id] = cart.id
      cart
    end

end

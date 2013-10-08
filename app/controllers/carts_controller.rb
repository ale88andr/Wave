class CartsController < ApplicationController
  def show
    @cart = Cart.find_by_id(params[:id])
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id ] = nil
    redirect_to root_path, notice: 'Теперь ваша корзина пуста!'
  end
end
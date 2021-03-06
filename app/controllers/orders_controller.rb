﻿class OrdersController < ApplicationController

  def create
    @order = current_cart.add_product(params[:entity_id])
    if @order.save
      redirect_to @order.cart, notice: 'Ваш заказ добавлен в корзину'
    else
      redirect_to root_path, notice: 'Not implement'
    end
  end

  def destroy
  	@order = Order.find_by_id(params[:id])
  	@order.destroy and redirect_to cart_path(session[:cart_id])
  end

end
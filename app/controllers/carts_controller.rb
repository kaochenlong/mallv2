class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    session[:cart9527] = current_cart.serialize

    redirect_to products_path, notice: "商品已加入購物車!"
  end

  def show
  end

  def checkout
    @order = Order.new
  end

  def destroy
    session[:cart9527] = nil
    redirect_to products_path, notice: "購物車已清空!"
  end
end

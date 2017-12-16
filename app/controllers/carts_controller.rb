class CartsController < ApplicationController
  def add
    cart = Cart.from_hash(session[:cart9527])
    cart.add_item(params[:id])
    session[:cart9527] = cart.serialize

    redirect_to products_path, notice: "商品已加入購物車!"
  end
end

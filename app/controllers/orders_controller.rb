class OrdersController < ApplicationController
  def create
    # 建立訂單
    order = Order.new(order_params)

    current_cart.items.each do |item|
      order.order_items.build(
        product: item.product,
        quantity: item.quantity
      )
    end

    if order.save
      # 刷卡
      result = Braintree::Transaction.sale(
        :amount => current_cart.total_price,
        :payment_method_nonce => params[:payment_method_nonce]
      )

      if result.success?
        # 清空 Cart
        session[:cart9527] = nil
        # 走
        redirect_to products_path, notice: "感謝消費!"
      else
        # ...
      end
    else
      # ...
    end
  end

  private
  def order_params
    params.require(:order).permit(
      :receipent,
      :tel,
      :address,
      :email
    )
  end
end

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { Cart.new }

  context "基本功能" do
    it "每個 Cart Item 都可以計算它自己的金額（小計）" do
      p1 = Product.create(title: "ruby", price: 100)

      3.times { cart.add_item p1.id }

      expect(cart.items.first.total_price).to be 300
    end
  end
end

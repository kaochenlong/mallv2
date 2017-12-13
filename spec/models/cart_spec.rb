require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }

  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart.add_item 1

      expect(cart).not_to be_empty
    end

    it "如果加了相同種類的商品到購物車裡，購買項目（CartItem）並不會增加，但商品的數量會改變。" do
      3.times { cart.add_item 1 }
      3.times { cart.add_item 2 }
      2.times { cart.add_item 1 }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      p1 = Product.create(title: "ruby", price: 100)
      p2 = Product.create(title: "php", price: 200)

      3.times { cart.add_item p1.id }
      cart.add_item p2.id

      expect(cart.items.first.product).to be_a Product
      expect(cart.items.last.product_id).to be p2.id
    end

    it "可以計算整台購物車的總消費金額" do
      p1 = Product.create(title: "ruby", price: 100)
      p2 = Product.create(title: "php", price: 200)

      3.times { cart.add_item p1.id }
      2.times { cart.add_item p2.id }

      expect(cart.total_price).to be 700
    end

    it "特別活動可搭配折扣（例如聖誕節的時候全面打 9 折）" do
      p1 = Product.create(title: "ruby", price: 100)
      p2 = Product.create(title: "php", price: 200)

      3.times { cart.add_item p1.id }
      2.times { cart.add_item p2.id }

      xmas = Time.local(2017, 12, 25, 12, 0, 0)
      Timecop.travel(xmas) do
        expect(cart.total_price).to be (700 * 0.9)
      end
    end

    # it "滿千送百"
  end

  context "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡。" do
      3.times { cart.add_item 1 }
      5.times { cart.add_item 2 }

      expect(cart.serialize).to eq cart_hash
    end
    # 也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容。
  end

  private
  def cart_hash
    {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 5}
      ]
    }
  end
end

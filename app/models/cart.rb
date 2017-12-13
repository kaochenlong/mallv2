class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def serialize
    item_list = items.map { |item|
      { "product_id" => item.product_id, "quantity" => item.quantity }
    }

    { "items" => item_list }
  end

  def self.from_hash(hash)
  end

  def add_item(id)
    found_item = @items.find { |item| item.product_id == id }

    if found_item
      found_item.increment
    else
      @items << CartItem.new(id)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price
    total = items.reduce(0) { |sum, item| sum + item.total_price }

    case
    when xmas?
      total * 0.9
    else
      total
    end
  end

  private
  def xmas?
    Time.now.month == 12 && Time.now.day == 25
  end
end

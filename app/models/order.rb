class Order < ApplicationRecord
  has_many :order_items

  include AASM

  aasm column: :state do
    state :pending, :initial => true
    state :paid, :shipped, :delivered, :refunded

    event :pay do
      transitions :from => :pending, :to => :paid
    end

    event :ship do
      transitions :from => :paid, :to => :shipped
      after_commit do
        puts "發送簡訊!"
      end
    end

    event :deliver do
      transitions :from => :shipped, :to => :delivered
    end

    event :refund do
      transitions :from => [:delivered, :paid], :to => :refunded
    end
  end

end

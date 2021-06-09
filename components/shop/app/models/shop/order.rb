# frozen_string_literal: true

# status: shopping_cart, placed, processing, shipping, complete, canceled
# user: optional
# buyer: anonymous user
# shipment_address

module Shop
  class Order < ApplicationRecord
    self.table_name = 'shop_orders'

    enum status: { shopping_cart: 0, placed: 1, processing: 2, shipping: 3, complete: 4, canceled: 5 }

    has_many :order_items
    has_many :items, through: :order_items

    def total_sum
      order_items.map(&:price).sum.to_f
    end

    def order_items_count
      order_items.count
    end
  end
end

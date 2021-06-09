# frozen_string_literal: true

# status: shopping_cart, placed, processing, shipping, complete, canceled
# user: optional
# buyer: anonymous user
# shipment_address

module Shop
  class Order < ApplicationRecord
    self.table_name = 'shop_orders'

    has_many :order_items

    def total
      @totoal ||= 0
    end
  end
end

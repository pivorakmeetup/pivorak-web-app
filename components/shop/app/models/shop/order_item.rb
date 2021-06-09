# frozen_string_literal: true

# item_id
# qty
# price

module Shop
  class OrderItem < ApplicationRecord
    self.table_name = 'shop_orders'

    belongs_to :order
    belongs_to :item
  end
end

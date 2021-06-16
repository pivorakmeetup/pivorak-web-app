# frozen_string_literal: true

module Shop
  class OrderItem < ApplicationRecord
    self.table_name = 'shop_order_items'

    validates_uniqueness_of :item_id

    belongs_to :order
    belongs_to :item
  end
end

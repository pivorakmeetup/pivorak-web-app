# frozen_string_literal: true

module Shop
  class OrderItem < ApplicationRecord
    self.table_name = 'shop_order_items'

    validates_uniqueness_of :item_id

    belongs_to :order
    belongs_to :item

    def increase_quantity!
      self.quantity += 1
      update_price(quantity)
      save!
    end

    def reduce_quantity!
      if self.quantity > 1
        self.quantity -= 1
        update_price(quantity)
        save!
      else
        delete_order_item
      end
    end

    def delete_order_item
      destroy!
    end

    def update_price(qty)
      self.price = item.price * qty
    end
  end
end

# frozen_string_literal: true

module Shop
  class Item < ApplicationRecord
    self.table_name = 'shop_items'

    has_many :item_images
    has_many :order_items
    accepts_nested_attributes_for :item_images

    scope :active, -> { where(published: true) }

    validates :name,          presence: true
    validates :price,         presence: true
    validates :available_qty, presence: true
  end
end

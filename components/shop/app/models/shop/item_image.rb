# frozen_string_literal: true

module Shop
  class ItemImage < ApplicationRecord
    self.table_name = 'shop_item_images'

    belongs_to :item
    mount_uploader :image, ItemImageUploader
  end
end

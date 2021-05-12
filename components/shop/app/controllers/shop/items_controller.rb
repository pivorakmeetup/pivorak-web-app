# frozen_string_literal: true

module Shop
  class ItemsController < BaseController
    helper_method :items

    private

    def items
      @items ||= Shop::Item.all
    end
  end
end

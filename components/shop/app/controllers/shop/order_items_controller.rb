# frozen_string_literal: true

module Shop
  class OrderItemsController < BaseController
    helper_method :item

    def index
    end

    def update
    end

    def destroy
    end

    private

    def item
      @items ||= Shop::Item.find(params[:id])
    end
  end
end

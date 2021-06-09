# frozen_string_literal: true

module Shop
  class OrderItemsController < BaseController
    helper_method :item
    helper_method :order_items
    helper_method :current_order

    def create
      order_item = ::Shop::OrderItem.new(item_id: item.id, order_id: order_id, price: item.price)
      order_item.save

      redirect_to shop_items_path
    end

    def update
      order_item.increase_quantity!
      redirect_to shop_order_items_path
    end

    def destroy
      order_item.reduce_quantity!
      redirect_to shop_order_items_path
    end

    private

    def order_items
      order_items = Shop::OrderItem.includes(:item)
    end

    def order_item
      @order_items ||= Shop::OrderItem.find(params[:id])
    end

    def item
      @items ||= Shop::Item.find(params[:item_id])
    end

    def order_id
      session[:order_id] ||= Shop::Order.create.id
    end
  end
end

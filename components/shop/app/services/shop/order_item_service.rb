module Shop
  class OrderItemService
    attr_reader :order_item

    def initialize(order_item)
      @order_item = order_item
    end

    def increase_quantity!
      order_item.increment!(:quantity)
    end

    def reduce_quantity!
      if order_item.quantity > 1
        order_item.decrement!(:quantity)
      else
        order_item.destroy!
      end
    end
  end
end

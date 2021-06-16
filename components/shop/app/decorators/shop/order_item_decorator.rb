module Shop
  class OrderItemDecorator < BaseDecorator
    def sum
      price * quantity
    end
  end
end

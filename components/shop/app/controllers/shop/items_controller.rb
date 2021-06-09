# frozen_string_literal: true

module Shop
  class ItemsController < BaseController
    helper_method :items
    helper_method :current_order

    # @deprecated
    # def add_to_cart
    #   cart = session[:cart] || []
    #   cart << item.id unless cart.include?(item.id)

    #   session[:cart] = cart

    #   redirect_back(fallback_location: root_path, notice: "#{item.name} was successfully added to cart")
    # end

    # def remove_from_cart
    #   session[:cart].delete(item.id)
    #   redirect_back(fallback_location: root_path, notice: "#{item.name} was successfully removed from cart")
    # end

    private

    def items
      @items ||= Shop::Item.active
    end
  end
end

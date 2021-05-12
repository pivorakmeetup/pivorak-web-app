# frozen_string_literal: true

module Admin
  module Shop
    class ItemsController < ::Admin::Shop::BaseController
      helper_method :item, :items

      def new
        @item = ::Shop::Item.new
        render_form
      end

      def edit
        item
        render_form
      end

      def create
        item = ::Shop::Item.new(items_params)

        react_to item.save
      end

      def update
        react_to item.update(items_params)
      end

      private

      def default_redirect
        redirect_to admin_shop_items_path
      end

      def item
        @item ||= ::Shop::Item.find(params[:id])
      end

      def items
        @items ||= ::Shop::Item.all
      end

      def items_params
        params.require(:item).permit(:name, :description, :price, :available_qty)
      end
    end
  end
end

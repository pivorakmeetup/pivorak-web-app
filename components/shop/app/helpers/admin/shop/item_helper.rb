# frozen_string_literal: true

module Admin
  module Shop
    module ItemHelper
      def item_form_url
        params[:action] == 'edit' ? admin_shop_item_path : admin_shop_items_path
      end

      def item_form_method
        params[:action] == 'edit' ? :put : :post
      end
    end
  end
end

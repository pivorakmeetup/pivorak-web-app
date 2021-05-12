# frozen_string_literal: true

module Admin
  module Shop
    module ShopHelper
      def admin_shop_items_nav
        render layout: '/admin/shop/shared/nav' do
          yield if block_given?
        end
      end

      def admin_shop_items_overview
        link_to icon(:book, t('courses.overview')),
                admin_shop_items_path
      end
    end
  end
end

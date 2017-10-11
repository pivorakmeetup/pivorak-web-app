module Admin
  module Bb
    module BbHelper
      def admin_bb_nav
        render layout: '/admin/bb/shared/nav' do
          yield if block_given?
        end
      end

      def admin_bb_active_item?(*ethalon_controller_names)
        ethalon_controller_names.each do |name|
          return 'active item' if controller_name == name
        end

        'item'
      end

      def admin_bb_members_link
        link_to icon(:users, t('bb.members.plural')),
                admin_bb_members_path,
                class: admin_bb_active_item?('seasons')
      end
    end
  end
end

module Admin
  module Members
    class SquashController < Admin::BaseController
      add_breadcrumb 'members.plural', :admin_members_path

      helper_method :member, :header_title, :squash_into_users

      def show
        add_breadcrumb 'words.squash'
      end

      def create
        User::Squash.call(
          squashed_user: member,
          into_user: ::User.find(params[:into_user])
        )

        flash_success and redirect_to(admin_members_path)
      end

      private

      def member
        @member ||= ::User.friendly.find(params[:member_id])
      end

      def header_title
        t 'members.plural'
      end

      def squash_into_users
        @squash_into_users ||= User.where.not(id: member.id)
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  module Members
    class BaseController < Admin::BaseController
      helper_method :member

      private

      def member
        @member ||= ::User.friendly.find(params[:member_id])
      end
    end
  end
end

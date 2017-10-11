module Admin
  module Bb
    class MembersController < Bb::BaseController
      helper_method :members

      private

      def members
        @memberds ||= ::Bb::Member.all
      end
    end
  end
end

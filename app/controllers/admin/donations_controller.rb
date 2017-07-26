module Admin
  class DonationsController < BaseController
    helper_method :donations

    private

      def donations
        @donations ||= search_against(Donation).includes(:user)
      end
  end
end
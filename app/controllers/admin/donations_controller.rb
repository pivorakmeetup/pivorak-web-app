module Admin
  class DonationsController < BaseController
    helper_method :donations

    private

      def donations
        @donations ||= search_against(Donation)
          .includes(:user)
          .page(params[:page])
          .order(created_at: :desc)
      end
  end
end
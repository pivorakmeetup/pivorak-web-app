module Admin
  class VisitRequest
    class CheckInController < ::Admin::BaseController
      helper_method :event, :upcoming_event, :user, :visit_request, :visit_count

      def show
        begin
          ::VisitRequest::CheckIn.new(visit_request).call
          render :show
        rescue ActiveRecord::RecordNotFound
          render :not_found
        rescue ::VisitRequest::CheckIn::AlreadyCheckedIn
          render :already_checked_in
        rescue ::VisitRequest::CheckIn::InvalidStatus
          render :invalid_status
        end
      end

      def not_found
        render :not_found
      end

      def already_checked_in
        render :already_checked_in
      end

      def invalid_status
        render :invalid_status
      end

      private

      def visit_request
        @visit_request ||= ::VisitRequest.find_by!(token: params[:token])
      end

      def user
        @user ||= visit_request.user
      end

      def event
        @event ||= visit_request.event
      end

      def upcoming_event
        @event ||= Event.upcoming
      end

      def visit_count
        @visit_count ||= User::VisitedEvents.call(user_id: user.id).count
      end
    end
  end
end

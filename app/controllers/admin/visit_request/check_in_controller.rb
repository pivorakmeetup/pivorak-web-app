module Admin
  class VisitRequest
    class CheckInController < ::Admin::BaseController
      helper_method :event, :upcoming_event, :user, :visit_request, :visit_count

      def show
        @visit_request, status = ::VisitRequest::CheckIn.new(visit_request).call
        if params[:redirect_back]
          redirect_back(fallback_location: admin_path)
        else
          render status
        end
      end

      private

      def visit_request
        @_visit_request ||= ::VisitRequest.find_by(token: params[:token])
      end

      def user
        @user ||= visit_request.user
      end

      def event
        @event ||= visit_request.event
      end

      def upcoming_event
        @event ||= Event.last
      end

      def visit_count
        @visit_count ||= User::VisitedEvents.call(user_id: user.id).count
      end
    end
  end
end

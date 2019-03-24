# frozen_string_literal: true

module Admin
  class VisitRequest
    class InviteController < VisitRequest::BaseController
      helper_method :form, :event

      before_action :only_supervisor!

      def create
        if form.valid?
          ::VisitRequest::Invite.call(emails: form.emails, event: event)
          flash[:notice] = t('visit_request.invite.success')
          redirect_to admin_event_visit_requests_path(event)
        else
          render :new
        end
      end

      private

      def form
        @form ||= ::InviteByEmailForm.new(visit_request_params)
      end

      def visit_request_params
        params.fetch(:invite_by_email_form, {}).permit(:emails)
      end

      def event
        @event ||= Event.friendly.find(params[:event_id])
      end
    end
  end
end

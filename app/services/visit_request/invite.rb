class VisitRequest
  class Invite < ApplicationService
    def initialize(emails:, event:)
      @emails = emails
      @event  = event
    end

    def call
      ::User::Import.call(emails: emails)
      visit_requests = ::VisitRequest::Import.call(event: event, emails: emails)
      visit_requests.each do |visit_request|
        VisitRequestMailer.attendance_confirmed(visit_request).deliver_later
      end
    end

    private

    attr_reader :emails, :event
  end
end

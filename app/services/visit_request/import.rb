class VisitRequest
  class Import < ApplicationService
    def initialize(event:, emails:, separator: ',')
      @event       = event
      @separator   = separator.strip
      @emails = emails
    end

    # @return <VisitRequest> returns list of newly created/found visit requests
    def call
      emails.split(separator).map do |email|
        user = ::User.find_by(email: email.strip)
        next unless user

        event.visit_requests.where(
          user: user,
          status: :confirmed
        ).first_or_create
      end.compact
    end

    private

    attr_reader :event, :emails, :separator
  end
end

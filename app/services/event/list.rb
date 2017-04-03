class Event
  class List < ::ApplicationService
    def initialize(params)
      @events = params[:events]
      @page   = params[:page]
    end

    def call
      events.includes(associations_to_include).order(started_at: :desc).page(page)
    end

    private

    attr_reader :events, :page

    def associations_to_include
      ::AssociationMapper.(visit_requests: %i(approved pending confirmed used), visitors: %i(verified newbie))
    end
  end
end

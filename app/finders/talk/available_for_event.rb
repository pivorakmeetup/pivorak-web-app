class Talk < ApplicationRecord
  class AvailableForEvent < ApplicationFinder
    def initialize(params = {})
      @event_id = params[:event_id]
    end

    def call
      Talk.where(event_id: event_id).or(Talk.where(event_id: nil)).sorted
    end

    private

    attr_reader :event_id
  end
end

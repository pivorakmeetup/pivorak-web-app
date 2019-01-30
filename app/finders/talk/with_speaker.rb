class Talk < ApplicationRecord
  class WithSpeaker < ApplicationFinder
    def initialize(event_id)
      @event_id = event_id
    end

    def call
      ::Talk.where(event_id: event_id).includes(:speaker).sort
    end

    private

    attr_reader :event_id
  end
end
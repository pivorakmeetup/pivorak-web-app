# frozen_string_literal: true

class Event
  class SlotsPolicy
    delegate :limit_verified, :limit_newbies, :visit_requests, to: :event

    attr_reader :event, :options

    def initialize(event, options = {})
      @event   = event
      @options = options
    end

    def free_verified_slots?
      (limit_verified - approved_visitors(:verified).count).positive?
    end

    def free_newbies_slots?
      (limit_newbies - approved_visitors(:newbies).count).positive?
    end

    def free_slot_for?(user)
      user.verified ? free_verified_slots? : free_newbies_slots?
    end

    private

    def approved_visitors(type)
      return unless %i[verified newbies].include?(type)

      visit_requests.approved.joins(:user).merge(User.send(type))
    end
  end
end

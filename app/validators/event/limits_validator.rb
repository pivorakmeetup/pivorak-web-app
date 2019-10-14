# frozen_string_literal: true

class Event
  class LimitsValidator < ActiveModel::Validator
    def validate(event)
      total_less_verified(event)
    end

    private

    def total_less_verified(event)
      return unless event.limit_total && event.limit_verified

      return if event.limit_total >= event.limit_verified

      event.errors.add :limit_verified, I18n.t('errors.total_less_verified')
    end
  end
end

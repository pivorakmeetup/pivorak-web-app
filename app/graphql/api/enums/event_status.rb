# frozen_string_literal: true

module Api
  module Enums
    class EventStatus < BaseEnum
      value 'REGISTRATION', 'Registration has been opened',                                        value: 'registration'
      value 'CONFIRMATION', 'Confirmation phase. You should confirm or refuse your visit request', value: 'confirmation'
      value 'LIVE',         'Event is live. Please, check-in at the entrance',                     value: 'live'
      value 'PASSED',       'Event has been passed. Thanks for visiting!',                         value: 'passed'
    end
  end
end

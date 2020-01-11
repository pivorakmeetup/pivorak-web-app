# frozen_string_literal: true

module Api
  module Enums
    class VisitStatus < BaseEnum
      value 'PENDING',   'Visit request pending for admin approve',    value: 'pending'
      value 'APPROVED',  'Visit request has been approved by admin',   value: 'approved'
      value 'CANCELED',  'Visit request has been canceled by member',  value: 'canceled'
      value 'CONFIRMED', 'Visit request has been confirmed by member', value: 'confirmed'
      value 'REFUSED',   'Visit request has been refused by member',   value: 'refused'
    end
  end
end

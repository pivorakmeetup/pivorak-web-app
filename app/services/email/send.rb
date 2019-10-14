# frozen_string_literal: true

class Email
  class Send < ApplicationService
    def initialize(email:, recipient_ids:)
      @email = email
      @recipient_ids = recipient_ids
    end

    def call
      recipient_ids.each do |recipient_id|
        EmailMailer.custom(email.id, recipient_id).deliver_later
      end
    end

    private

    attr_reader :email, :recipient_ids
  end
end

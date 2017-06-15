class Email
  class Create < ApplicationService
    attr_reader :email

    def initialize(params:, recipient_ids:)
      @params = params
      @recipient_ids = recipient_ids
    end

    def call
      return false unless email.persisted?

      Email::Send.call(email: email, recipient_ids: recipient_ids)
      true
    end

    def email
      @email ||= Email.create(params)
    end

    private

    attr_reader :params, :recipient_ids
  end
end

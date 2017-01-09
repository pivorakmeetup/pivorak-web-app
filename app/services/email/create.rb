class Email
  class Create < ApplicationService
    attr_reader :email

    def initialize(params)
      @params = params
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

    def recipient_ids
      User.real.ids
    end

    attr_reader :params
  end
end

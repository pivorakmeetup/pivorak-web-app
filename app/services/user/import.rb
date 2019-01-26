class User
  class Import < ApplicationService
    def initialize(emails:, separator: ',')
      @separator   = separator.strip
      @emails = emails
    end

    def call
      (prepared_emails - existing_user_emails).each do |email|
        first_name = name_email_part(email).first
        last_name = name_email_part(email).last

        user = User.new(email: email, first_name: first_name, last_name: last_name)

        User::Create.call(user, {}, synthetic: true)
      end
    end

    private

    attr_reader :emails, :separator

    def prepared_emails
      @prepared_emails ||= emails.split(separator).map(&:strip).reject(&:blank?)
    end

    def existing_user_emails
      User.where(email: prepared_emails).pluck(:email)
    end

    def name_email_part(email)
      email.split('@')[0].split('.')
    end
  end
end

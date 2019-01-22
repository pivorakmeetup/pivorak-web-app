class InviteByEmailForm
  include ActiveModel::Model

  DELIMITER = ','.freeze

  attr_accessor :emails

  validates :emails, presence: true
  validate :emails_are_valid

  private

  def emails_are_valid
    return if emails.blank?

    invalid_emails = email_list.select do |email|
      !email.strip.match(Devise.email_regexp)
    end

    return if invalid_emails.empty?

    errors.add(:emails, I18n.t('invite_by_email_form.emails.error', invalid_emails: invalid_emails.join(DELIMITER)))
  end

  def email_list
    emails.split(DELIMITER).reject(&:blank?)
  end
end

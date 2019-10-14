# frozen_string_literal: true

class UserMailerPreview
  def reset_password_instructions
    UserMailer.reset_password_instructions record, token
  end

  def confirmation_instructions
    UserMailer.confirmation_instructions record, token
  end

  private

  def record
    User.last
  end

  def token
    'token-token'
  end
end

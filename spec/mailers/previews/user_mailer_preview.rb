class UserMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.first
    token = 'abc'
    UserMailer.confirmation_instructions(user, token, {})
  end

  def reset_password_instructions
    user = User.first
    token = 'abc'
    UserMailer.reset_password_instructions(user, token, {})
  end
end

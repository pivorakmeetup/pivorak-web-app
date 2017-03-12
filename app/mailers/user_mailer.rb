class UserMailer < Devise::Mailer
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts = {})
    @token = token
    send_mail(record, token)
  end

  def reset_password_instructions(record, token, opts = {})
    send_mail(record, token)
  end

  private

  def send_mail(record, token)
    @token = token
    @user = record

    mail(to: @user.email, from: NO_REPLY_EMAIL, subject: email_template.subject) do |format|
      format.html { email_template.render(user: @user, token: @token) }
    end
  end
end

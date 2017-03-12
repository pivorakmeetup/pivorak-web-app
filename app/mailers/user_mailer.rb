class UserMailer < Devise::Mailer
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts = {})
    send_mail(record, token, opts)
  end

  def reset_password_instructions(record, token, opts={})
    send_mail(record, token, opts)
  end

  private

  def send_mail(record, token = nil, opts)
    @token = token
    @user = record

    mail(to: record.email, from: NO_REPLY_EMAIL, subject: email_template.subject) do |format|
      format.html { email_template.render(user: record, token: @token) }
    end
  end
end

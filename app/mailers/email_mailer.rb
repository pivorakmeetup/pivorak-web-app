class EmailMailer < ApplicationMailer
  def custom(email_id, user_id)
    email = Email.find(email_id)
    user = User.find(user_id)
    mail(subject: email.subject, to: user.email) do |format|
      format.html { email.body.html_safe }
    end
  end
end

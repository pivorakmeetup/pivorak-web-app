# frozen_string_literal: true

class EmailMailer < ApplicationMailer
  def custom(email_id, user_id)
    email = Email.find(email_id)
    user = User.find(user_id)
    mail(subject: email.subject, to: user.email) do |format|
      format.html { MarkdownRenderer.call(email.body) }
    end
  end
end

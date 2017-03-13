class EmailMailerPreview
  def custom
    email_id = Email.last.id
    user_id = User.last.id

    EmailMailer.custom email_id, user_id
  end
end

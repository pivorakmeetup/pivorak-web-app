class NotifyMailerPreview
  def become_speaker
    NotifyMailer.become_speaker params
  end


  def new_user_registered
    NotifyMailer.new_user_registered user_id
  end
end

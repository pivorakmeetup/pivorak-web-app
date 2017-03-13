class NotifyMailerPreview
  def become_speaker
    params = {
      name: 'Matz',
      email: 'matz@mail.com',
      text: 'Hey, I wanna be a speaker in the best RUG in the world!'
    }
    NotifyMailer.become_speaker params
  end


  def new_user_registered
    user_id = User.last.id
    NotifyMailer.new_user_registered user_id
  end

  private

  def user_id

  end
end

class NotifyMailerPreview
  def become_speaker
    params = {
      name: 'Matz',
      email: 'matz@mail.com',
      text: 'Hey, I wanna be a speaker in the best RUG in the world!'
    }
    NotifyMailer.become_speaker params
  end

  private

  def user_id

  end
end

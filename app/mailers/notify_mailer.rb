class NotifyMailer < ApplicationMailer
  def become_speaker(params)
    name = params[:name]
    email = params[:email]
    text = params[:text]

    mail(from: "#{name} <#{email}>", subject: "I want to be a speaker", to: PIVORAK_EMAIL) do |format|
      format.html { text }
    end
  end
end

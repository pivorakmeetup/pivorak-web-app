class ApplicationMailer < ActionMailer::Base
  PIVORAK_EMAIL = 'pivorak.me@gmail.com'
  NO_REPLY_EMAIL = 'no-reply@pivorak.com'
  default from: PIVORAK_EMAIL
  layout 'mailer'
  default template_path: -> (mailer) { "mailers/#{mailer.class.name.underscore}" }
end

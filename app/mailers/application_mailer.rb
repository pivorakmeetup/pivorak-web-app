class ApplicationMailer < ActionMailer::Base
  PIVORAK_EMAIL = 'pivorak.me@gmail.com'
  default from: 'from@example.com'
  layout 'mailer'
end

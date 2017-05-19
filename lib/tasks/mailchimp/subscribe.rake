namespace :mailchimp do
  desc 'adds existing users to Mailchimp subscription list'
  task subscribe: :environment do
    p 'Adding existing users to Mailchimp subscription list'
    User.all.each { |user| ::Mailchimp::User::Subscribe.call(user: user) }
    p 'Subscription process has completed'
  end
end

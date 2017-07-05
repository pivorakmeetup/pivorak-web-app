namespace :mailchimp do
  desc 'adds existing users to Mailchimp subscription list'
  task subscribe: :environment do
    p 'Adding existing users to Mailchimp subscription list'
    User.where(subscribed: true).each do |user|
     ::Mailchimp::User::Subscribe.call(user: user)
    end
    p 'Subscription process has completed'
  end
end

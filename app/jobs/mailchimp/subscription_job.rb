module Mailchimp
  class SubscriptionJob < ::ApplicationJob
    def perform(user_id)
      user = ::User.find_by(id: user_id, subscribed: true)

      return unless user

      logger.info("#{user.email} is being added to Mailchimp subscription list")
      response = ::Mailchimp::User::Subscribe.call(user: user)
      logger.info("Mailchimp response for #{user.email} - #{response.body[:status]}") if response
    end
  end
end

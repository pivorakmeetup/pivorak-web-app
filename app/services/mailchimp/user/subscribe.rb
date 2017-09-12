module Mailchimp
  module User
    class Subscribe < ::ApplicationService
      def initialize(params)
        @user = params[:user]
      end

      def call
        @response ||= members(mail_hash).upsert(body: payload)
      rescue Gibbon::MailChimpError => e
        logger.warn("Mailchimp Subscription Error: #{e.message}") && return
      end

      private

      def mail_hash
        @mail_hash ||= Digest::MD5.hexdigest(user_email.downcase)
      end

      def subscription_list
        @subscription_list ||= lists(ENV['MAILCHIMP_LIST_ID'])
      end

      def payload
        {
          email_address: user_email,
          status:        :subscribed,
          merge_fields:  user_payload
        }
      end

      def user_payload
        {
          FNAME: user_first_name,
          LNAME: user_last_name
        }
      end

      attr_reader :user

      delegate    :email, :first_name, :last_name, to: :user, prefix: true
      delegate    :members,                        to: :subscription_list
      delegate    :lists,                          to: 'Gibbon::Request'
      delegate    :logger,                         to: 'Rails'
    end
  end
end

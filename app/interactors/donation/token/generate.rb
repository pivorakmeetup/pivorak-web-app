class Donation < ApplicationRecord
  module Token
    class Generate
      include Interactor

      def call
        context.card = token
      end

      private

      def token
        @token ||= ::Stripe::Token::Create.call(context)
      end
    end
  end
end

class Donation < ApplicationRecord
  module Customer
    class Create
      include Interactor

      def call
        context.customer = customer
      end

      private

      def customer
        @customer ||= ::Stripe::Customer::Create.call(context)
      end
    end
  end
end

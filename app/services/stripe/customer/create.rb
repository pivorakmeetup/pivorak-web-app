module Stripe
  class Customer
    class Create
      def self.call(params)
        new(params).perform
      end

      def initialize(params)
        @email  = params[:email]
        @card   = params[:card]
      end

      def perform
        @customer ||= Stripe::Customer.create(customer_params)
      end

      private

      attr_reader :email, :card

      def customer_params
        {
          email:  email,
          card:   card
        }
      end
    end
  end
end

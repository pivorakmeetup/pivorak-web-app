module Stripe
  class Charge
    class Create
      def self.call(params)
        new(params).perform
      end

      def initialize(params)
        @customer    = params[:customer]
        @amount      = params[:amount]
        @description = params[:description]
      end

      def perform
        @charge ||= Stripe::Charge.create(charge_params)
      end

      private

      def amount
        @amount.to_i * 100
      end

      attr_reader :customer, :description

      def charge_params
        {
          customer:    customer,
          amount:      amount,
          description: description,
          currency:    DEFAULT_CURRENCY
        }
      end

      DEFAULT_CURRENCY = 'UAH'.freeze
    end
  end
end

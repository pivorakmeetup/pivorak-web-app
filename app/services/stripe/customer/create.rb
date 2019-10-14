# frozen_string_literal: true

module Stripe
  class Customer
    class Create < ::ApplicationService
      def initialize(params)
        @email  = params[:email]
        @card   = params[:card]
      end

      def call
        Stripe::Customer.create(customer_params)
      end

      private

      attr_reader :email, :card

      def customer_params
        {
          email: email,
          card:  card
        }
      end
    end
  end
end

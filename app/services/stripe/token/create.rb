# frozen_string_literal: true

module Stripe
  class Token
    class Create < ::ApplicationService
      def initialize(params)
        @number    = params[:number]
        @cvc       = params[:cvc]
        @exp_month = params[:exp_month]
        @exp_year  = params[:exp_year]
      end

      def call
        Stripe::Token.create(card: token_params)
      end

      private

      attr_reader :number, :exp_month, :exp_year, :cvc

      def token_params
        {
          number:    number,
          cvc:       cvc,
          exp_month: exp_month,
          exp_year:  exp_year
        }
      end
    end
  end
end

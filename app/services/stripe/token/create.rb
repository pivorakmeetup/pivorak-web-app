module Stripe
  class Token
    class Create
      def self.call(params)
        new(params).perform
      end

      def initialize(params)
        @number    = params[:number]
        @cvc       = params[:cvc]
        @exp_month = params[:exp_month]
        @exp_year  = params[:exp_year]
      end

      def perform
        @token ||= Stripe::Token.create(card: token_params)
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

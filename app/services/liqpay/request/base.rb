module Liqpay
  module Request
    class Base < ApplicationService
      attr_reader :data, :signature, :url

      def initialize(options={})
        @customer    = options[:user_id].to_s
        @public_key  = ENV['LIQPAY_PUBLIC_KEY']
        @private_key = ENV['LIQPAY_PRIVATE_KEY']
        @version     = 3
        @url         = 'https://www.liqpay.com/api/3/checkout'
        @raw_data    = sending_data
      end

      def call
        self
      end

      def data
        ::Liqpay::Request::Data.(raw_data)
      end

      def signature
        ::Liqpay::Request::Signature.(private_key: private_key, request_data: data)
      end

      private

      attr_reader :customer, :raw_data, :version, :public_key, :private_key

      def sending_data
        {
          version:     version,
          action:      'paydonate',
          public_key:  public_key,
          amount:      '30',
          currency:    'UAH',
          description: 'Pivorak donation',
          type:        'donate',
          server_url:  'https://pivorak.com/payment_handler',
          language:    'en',
          customer:    customer
        }.to_json
      end
    end
  end
end

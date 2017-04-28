module Liqpay
  module Request
    class Data < ::Liqpay::Request::Base
      def initialize(data)
        @raw_data = data
      end

      def call
        Base64.strict_encode64(raw_data)
      end

      private

      attr_reader :raw_data
    end
  end
end

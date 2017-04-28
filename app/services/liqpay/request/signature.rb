module Liqpay
  module Request
    class Signature < ::Liqpay::Request::Base
      def initialize(options)
        @private_key  = options[:private_key]
        @request_data = options[:request_data]
      end

      def call
        Base64.strict_encode64(signature)
      end

      private

      attr_reader :privat_key, :request_data

      def signature
        @signature ||= Digest::SHA1.digest(signature_data)
      end

      def signature_data
        @signature_data ||= "#{private_key}#{request_data}#{private_key}"
      end
    end
  end
end

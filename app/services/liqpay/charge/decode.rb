module Liqpay
  module Charge
    class Decode < ApplicationService
      def initialize(data)
        @data = data
      end

      def call
        parsed_data
      end

      private

      attr_reader :data

      def parsed_data
        json_string = decoded_data

        return unless json_string

        JSON.parse(json_string)
      rescue JSON::ParserError
        false
      end

      def decoded_data
        Base64.decode64(data)
      rescue
        false
      end
    end
  end
end

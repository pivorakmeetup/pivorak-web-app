# frozen_string_literal: true

module Omniauth
  class Resolver
    class Default
      def initialize(params)
        @params = params
      end

      %i[uid provider].each do |method_name|
        define_method method_name do
          params[method_name]
        end
      end

      def email
        info[:email]
      end

      def first_name
        name&.first
      end

      def last_name
        name&.last
      end

      protected

      attr_reader :params

      def name
        @name ||= info[:name]&.split(' ')
      end

      def info
        @info ||= params.fetch(:info, {})
      end
    end
  end
end

module Omniauth
  class Resolver
    class Default
      def initialize(params)
        @params = params
      end

      %i(uid provider).each do |method_name|
        define_method method_name do
          params[method_name]
        end
      end

      %i(first_name last_name email).each do |method_name|
        define_method method_name do
          info[method_name]
        end
      end

      protected

      attr_reader :params

      def info
        @info ||= params.fetch(:info, {})
      end
    end
  end
end

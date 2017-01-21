module Omniauth
  class Resolver
    class Twitter < Default
      def first_name
        name&.first
      end

      def last_name
        name&.last
      end

      private

      def name
        @name ||= info[:name]&.split(' ')
      end
    end
  end
end

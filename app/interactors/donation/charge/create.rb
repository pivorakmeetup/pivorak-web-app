class Donation < ApplicationRecord
  module Charge
    class Create
      include Interactor

      def call
        context.charge = charge
      end

      private

      def charge
        @charge ||= ::Stripe::Charge::Create.call(context)
      end
    end
  end
end

class Goal < ApplicationRecord
  module Donations
    class Persist
      include Interactor

      delegate :user, :goal, :amount, to: :context
      delegate :donations,            to: :goal

      def call
        context.donation = donations.create(amount: amount, user: user)
      end
    end
  end
end

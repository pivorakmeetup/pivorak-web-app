class Goal < ApplicationRecord
  module Donations
    class Setup
      include Interactor

      delegate :user, :goal, :anonymous, to: :context

      def call
        assign_description!
        assign_email!
      end

      private

      def assign_description!
        fail_context! unless goal
        context.description = goal.title
      end

      def assign_email!
        return context.delete_field(:user) if anonymous
        context.email = user&.email
      end

      def fail_context!
        context.fail!(message: I18n.t('resources.errors.not_found', resource: Goal))
      end
    end
  end
end

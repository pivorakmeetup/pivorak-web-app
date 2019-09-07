# frozen_string_literal: true

module Api
  module Queries
    class Me < BaseQuery
      type Types::MemberType, null: false

      def resolve
        context[:current_user]
      end
    end
  end
end

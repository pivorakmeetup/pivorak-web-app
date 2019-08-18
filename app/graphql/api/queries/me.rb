# frozen_string_literal: true

module Api
  module Queries
    class Me < BaseQuery
      type Types::MemberType, null: false

      description 'Current member profile info'

      def resolve
        context[:current_user]
      end
    end
  end
end

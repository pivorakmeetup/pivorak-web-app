# frozen_string_literal: true

module Api
  module Types
    class MemberType < BaseType
      field :id, ID, null: false
      field :email, String, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
    end
  end
end

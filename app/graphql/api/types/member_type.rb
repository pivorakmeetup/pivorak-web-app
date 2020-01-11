# frozen_string_literal: true

module Api
  module Types
    class MemberType < BaseType
      description 'Pivorak member **profile** info'

      field :id,          ID,      'Member ID',         null: false
      field :email,       String,  'Member email',      null: false
      field :first_name,  String,  'Member first name', null: false
      field :last_name,   String,  'Member last name',  null: false
      field :verified,
            Boolean,
            'Is member verified. Only verified members can get auto-approve at meetup events',
            null: false

      field :visits, [Types::VisitType], null: true do
        argument :pagination, InputObjects::Pagination, required: false
      end

      def visits(pagination: {})
        object.visit_requests.offset(pagination[:offset]).limit(pagination[:limit])
      end
    end
  end
end

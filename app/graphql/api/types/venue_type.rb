# frozen_string_literal: true

module Api
  module Types
    class VenueType < BaseType
      description 'Pivorak venue info'

      field :id,          ID,     'Venue ID',                 null: false
      field :name,        String, 'Venue name',               null: false
      field :address,     String, 'Address of the venue',     null: false
      field :description, String, 'Description of the venue', null: true
    end
  end
end

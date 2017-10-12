module Searchable
  module Configuration
    module Venue
      include Configurable
      include SearchOptions

      VENUE_FIELDS = %i(name address description)

      define_searchable do
        multisearchable          against: VENUE_FIELDS
        pg_search_scope :search, against: VENUE_FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

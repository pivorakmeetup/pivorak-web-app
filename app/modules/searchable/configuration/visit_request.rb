module Searchable
  module Configuration
    module VisitRequest
      include Configurable
      include SearchOptions

      FIELDS = %i(first_name last_name)

      define_searchable do
        pg_search_scope :search, associated_against: { user: FIELDS }, using: TSEARCHABLE_WITH_PREFIX_ANY_WORD
      end
    end
  end
end

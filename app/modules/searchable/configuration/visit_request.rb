module Searchable
  module Configuration
    module VisitRequest
      include Configurable
      include SearchOptions

      USER_FIELDS = %i(first_name last_name)

      define_searchable do
        pg_search_scope :search,
          using: TSEARCHABLE_WITH_PREFIX_ANY_WORD,
          associated_against: {
            user: USER_FIELDS
          }
      end
    end
  end
end

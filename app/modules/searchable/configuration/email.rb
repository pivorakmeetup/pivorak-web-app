module Searchable
  module Configuration
    module Email
      include Configurable
      include SearchOptions

      FIELDS = %i(subject body)

      define_searchable do
        pg_search_scope :search, against: FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

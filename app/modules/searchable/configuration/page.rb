module Searchable
  module Configuration
    module Page
      include Configurable
      include SearchOptions

      FIELDS = %i(title url)

      define_searchable do
        pg_search_scope :search, against: FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

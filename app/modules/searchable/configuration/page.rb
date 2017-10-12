module Searchable
  module Configuration
    module Page
      include Configurable
      include SearchOptions

      PAGE_FIELDS = %i(title url)

      define_searchable do
        pg_search_scope :search, against: PAGE_FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

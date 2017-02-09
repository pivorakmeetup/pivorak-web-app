module Searchable
  module Configuration
    module Friend
      include Configurable
      include SearchOptions

      FIELDS = %i(name)

      define_searchable do
        pg_search_scope :search, against: FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

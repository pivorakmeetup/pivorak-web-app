module Searchable
  module Configuration
    module Friend
      include Configurable
      include SearchOptions

      FRIEND_FIELDS = %i(name)

      define_searchable do
        pg_search_scope :search, against: FRIEND_FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

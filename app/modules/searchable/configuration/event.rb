module Searchable
  module Configuration
    module Event
      include Configurable
      include SearchOptions

      EVENT_FIELDS = %i(title description agenda)

      define_searchable do
        multisearchable          against: EVENT_FIELDS
        pg_search_scope :search, against: :title, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

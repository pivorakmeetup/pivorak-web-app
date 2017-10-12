module Searchable
  module Configuration
    module Goal
      include Configurable
      include SearchOptions

      GOAL_FIELDS = %i(title description)

      define_searchable do
        multisearchable          against: GOAL_FIELDS
        pg_search_scope :search, against: GOAL_FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

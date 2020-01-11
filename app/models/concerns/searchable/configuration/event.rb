# frozen_string_literal: true

module Searchable
  module Configuration
    module Event
      include Configurable
      include SearchOptions

      FIELDS = %i[title description agenda].freeze

      define_searchable do
        multisearchable          against: FIELDS
        pg_search_scope :search, against: :title, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

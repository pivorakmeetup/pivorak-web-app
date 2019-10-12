# frozen_string_literal: true

module Searchable
  module Configuration
    module Friend
      include Configurable
      include SearchOptions

      FIELDS = %i[name].freeze

      define_searchable do
        pg_search_scope :search, against: FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

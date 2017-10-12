module Searchable
  module Configuration
    module User
      include Configurable
      include SearchOptions

      USER_FIELDS = %i(first_name last_name email)

      define_searchable do
        multisearchable          against: USER_FIELDS
        pg_search_scope :search, against: USER_FIELDS, using: TSEARCHABLE_WITH_PREFIX
      end
    end
  end
end

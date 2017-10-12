module Searchable
  module Configuration
    module Talk
      include Configurable
      include SearchOptions

      TALK_FIELDS    = %i(title description)
      TAG_FIELDS     = %i(name)
      SPEAKER_FIELDS = %i(first_name last_name)

      define_searchable do
        multisearchable against: TALK_FIELDS
        pg_search_scope :search,
          against: TALK_FIELDS,
          using:   TSEARCHABLE_WITH_PREFIX,
          associated_against: {
            speaker: SPEAKER_FIELDS,
            tags:    TAG_FIELDS
          }
      end
    end
  end
end

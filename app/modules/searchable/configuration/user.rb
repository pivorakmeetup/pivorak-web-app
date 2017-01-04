module Searchable
  module Configuration
    module User
      include Configurable

      define_searchable do
        pg_search_scope :by_email, against: :email, using: { tsearch: { prefix: true } }

        multisearchable            against: %i(first_name last_name email)
      end
    end
  end
end

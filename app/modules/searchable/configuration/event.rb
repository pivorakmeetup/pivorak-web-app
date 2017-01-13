module Searchable
  module Configuration
    module Event
      include Configurable

      define_searchable do
        %i(title agenda description).each do |attribute|
          pg_search_scope "by_#{attribute}", against: attribute
        end
      end
    end
  end
end

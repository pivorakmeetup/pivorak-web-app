# frozen_string_literal: true

module Search
  class Multisearch < Base
    private

    def collection
      @collection ||= multisearch(query)
    end

    delegate :multisearch,   to: :search_module
    delegate :search_module, to: Searchable
  end
end

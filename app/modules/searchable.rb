# frozen_string_literal: true

module Searchable
  class << self
    def included(base)
      base.include(search_module)

      resolver.call(target: base)
    end

    def search_module
      PgSearch
    end

    def resolver
      ::Searchable::Resolver
    end
  end
end

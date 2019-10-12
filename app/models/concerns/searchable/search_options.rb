# frozen_string_literal: true

module Searchable
  module SearchOptions
    TSEARCHABLE_WITH_PREFIX          = { tsearch: { prefix: true } }.freeze
    TSEARCHABLE_WITH_PREFIX_ANY_WORD = TSEARCHABLE_WITH_PREFIX.deep_merge(tsearch: { any_word: true })
  end
end

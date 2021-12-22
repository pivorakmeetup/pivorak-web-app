# frozen_string_literal: true

module Searchable
  module Configurable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def define_searchable(&block)
        return unless block

        definitions << block
      end

      def definitions
        @definitions ||= []
      end
    end
  end
end

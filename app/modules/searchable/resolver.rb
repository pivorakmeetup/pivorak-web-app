module Searchable
  class Resolver < ::ApplicationService
    include Mapping

    def initialize(params)
      @target = params[:target]
    end

    def call
      Array(definitions).each { |definition| apply!(definition) }
    end

    private

    attr_reader :target

    delegate :model_name,  to: :target
    delegate :i18n_key,    to: :model_name, prefix: true
    delegate :definitions, to: :configuration, allow_nil: true

    def apply!(definition)
      target.class_exec(&definition)
    end

    def configuration
      @configuration ||= MAPPING[model_name_i18n_key]
    end
  end
end

module Omniauth
  class Resolver < ::ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      resolver_class.new(params)
    end

    private

    attr_reader :params

    def resolver_class
      Default
    end

    def provider
      @provider ||= params[:provider]&.to_sym
    end
  end
end

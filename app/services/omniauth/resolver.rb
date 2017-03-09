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
      (is_twitter? || is_facebook?) ? Twitter : Default
    end

    def is_twitter?
      provider == :twitter
    end

    def is_facebook?
      provider == :facebook
    end

    def provider
      @provider ||= params[:provider]&.to_sym
    end
  end
end

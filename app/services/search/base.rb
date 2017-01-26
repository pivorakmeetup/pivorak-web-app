module Search
  class Base < ::ApplicationService
    def initialize(params)
      @query      = params[:query]
      @formatter  = params[:formatter]
      @model      = params[:model]
    end

    def call
      return collection unless formatter

      formatter.call(collection: collection)
    end

    private

    attr_reader :query, :formatter, :model
  end
end

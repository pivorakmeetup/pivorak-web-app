module Search
  class Resource < Base
    private

    def collection
      return model unless query_present?

      @collection ||= search(query)
    end

    def query_present?
      query.present?
    end

    delegate :search, to: :model
  end
end

class VisitRequest
  class Find < ApplicationFinder
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      ::VisitRequest.find(params[:visit_request_id])
    end
  end
end

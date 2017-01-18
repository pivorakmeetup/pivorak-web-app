class VisitRequest
  class FinalConfirmation < ApplicationService
    YES = 'yes'
    NO  = 'no'

    def initialize(visit_request, params)
      @visit_request = visit_request
      @params        = params
    end

    def call
      return unless schema.call(params).success?
      return unless visit_request.token == params[:token]

      if yes?
        visit_request.confirmed!
      else
        visit_request.refused!
      end
    end

    private

    attr_reader :visit_request, :params

    def schema
      Dry::Validation.Schema do
        required(:answer).value(included_in?: [YES, NO])
        required(:token).filled
      end
    end

    def yes?
      params[:answer] == YES
    end
  end
end

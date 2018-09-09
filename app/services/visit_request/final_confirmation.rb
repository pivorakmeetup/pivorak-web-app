class VisitRequest
  class FinalConfirmation < ApplicationService
    YES = 'yes'
    NO  = 'no'

    UnrecognizedAnswerError = Class.new(StandardError)

    def initialize(visit_request, answer:)
      @visit_request = visit_request
      @answer        = answer
    end

    def call
      case answer
      when YES then visit_request.confirmed!
      when NO  then visit_request.refused!
      else     fail UnrecognizedAnswerError
      end
    end

    private

    attr_reader :visit_request, :answer
  end
end

class VisitRequest
  class FinalDecision < ApplicationService
    YES = 'yes'
    NO  = 'no'

    UnrecognizedAnswerError = Class.new(StandardError)

    def initialize(visit_request, answer:)
      @visit_request = visit_request
      @answer        = answer
    end

    def call
      case answer
      when YES
        VisitRequest::Confirm.call(visit_request)
      when NO
        VisitRequest::Refuse.call(visit_request)
      else
        fail UnrecognizedAnswerError
      end
    end

    private

    attr_reader :visit_request, :answer
  end
end

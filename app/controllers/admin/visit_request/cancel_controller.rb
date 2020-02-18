# frozen_string_literal: true

module Admin
  class VisitRequest
    class CancelController < VisitRequest::BaseController
      def update
        ::VisitRequest::Cancel.call(visit_request)

        head :ok
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  class VisitRequest
    class ToggleListController < VisitRequest::BaseController
      def update
        ::VisitRequest::ToggleList.call(visit_request)

        head :ok
      end
    end
  end
end

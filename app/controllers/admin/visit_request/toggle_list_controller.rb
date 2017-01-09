module Admin
  class VisitRequest
    class ToggleListController < VisitRequest::BaseController
      def update
        ::VisitRequest::ToggleList.call(visit_request)

        default_redirect
      end
    end
  end
end

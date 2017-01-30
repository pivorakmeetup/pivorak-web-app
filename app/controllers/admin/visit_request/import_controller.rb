module Admin
  class VisitRequest
    class ImportController < VisitRequest::BaseController
      def create
        ::VisitRequest::Import.call(event, params[:separator], params[:emails_list])

        default_redirect
      end
    end
  end
end

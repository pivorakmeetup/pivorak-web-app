module Admin
  class VisitRequest
    class ImportController < VisitRequest::BaseController
      def create
        ::VisitRequest::Import.call(event: event, emails: params[:emails_list], separator: params[:separator])

        default_redirect
      end
    end
  end
end

module Admin
  module Courses
    module InterviewHelper
      def interview_form_url
        params[:action] == 'edit' ? admin_courses_season_interview_path : admin_courses_season_interviews_path
      end

      def interview_form_method
        params[:action] == 'edit' ? :put : :post
      end
    end
  end
end

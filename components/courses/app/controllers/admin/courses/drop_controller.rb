module Admin
  module Courses
    class DropController < ::Admin::Courses::BaseController
      skip_before_action :execute_show_tab_policy

      def create
        ::Courses::Student::Drop.call(student)
        redirect_back(
          fallback_location: admin_courses_season_students_path(current_season)
        )
      end

      private

      def student
        @student ||= current_season.students.find(params[:student_id])
      end
    end
  end
end

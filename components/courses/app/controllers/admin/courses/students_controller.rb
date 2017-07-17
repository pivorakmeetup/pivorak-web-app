module Admin
  module Courses
    class StudentsController < BaseController
      helper_method :students
      before_action :add_season_breadcrumb, :add_student_breadcrumb

      private

      def students
        @students ||= current_season.students.includes(:user)
      end

      def add_season_breadcrumb
       add_breadcrumb current_season, path: admin_courses_season_path(current_season)
      end

      def add_student_breadcrumb
       add_breadcrumb 'students.plural', path: admin_courses_season_students_path(current_season)
      end
    end
  end
end

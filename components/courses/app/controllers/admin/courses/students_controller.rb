module Admin
  module Courses
    class StudentsController < BaseController
      helper_method :students

      breadcrumps do
        add :students_breadcrumb
      end

      private

      def students
        @students ||= current_season.students.includes(:user).page(params[:page])
      end

      def students_breadcrumb
        add_breadcrumb 'courses.students.plural',
          path: admin_courses_season_students_path(current_season)
      end
    end
  end
end

module Admin
  module Courses
    class StudentsController < ::Admin::Courses::BaseController
      helper_method :students, :student, :total

      breadcrumps do
        add :students_breadcrumb
        add :student_breadcrumb, only: :show
      end

      def update
        student.update(student_params) ? flash_success : flash_error

        redirect_to admin_courses_season_student_path(current_season, student)
      end

      private

      def default_redirect
        redirect_to admin_courses_season_interviews_path(current_season)
      end

      def students
        @students ||= ::Courses::Season::StudentsPerStatus.call(current_season)
      end

      def student
        @student ||= ::Courses::Student.find(params[:id])
      end

      def total(student)
        ::Courses::Student::TotalHash.call(students)[student][:total]
      end

      def students_breadcrumb
        add_breadcrumb 'courses.students.plural',
          path: admin_courses_season_students_path(current_season)
      end

      def student_breadcrumb
        add_breadcrumb student, label: :full_name,
          path: admin_courses_season_students_path(current_season)
      end

      def student_params
        params.require(:student).permit(:status, :notes)
      end
    end
  end
end

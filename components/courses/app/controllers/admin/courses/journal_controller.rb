module Admin
  module Courses
    class JournalController < ::Admin::Courses::BaseController
      helper_method :students, :lectures, :total_hash

      breadcrumps do
        add :journal_breadcrumb
      end

      private

      def journal_breadcrumb
       add_breadcrumb 'courses.journal.singular',
         path: admin_courses_season_journal_path(current_season)
      end

      def students
        @students ||= ::Courses::Student::AttendingAndGraduated
          .call(current_season, [:user, :progresses])
      end

      def lectures
        @lectures ||= current_season.lectures.order(:started_at)
      end

      def total_hash
        @total_hash ||= ::Courses::Student::TotalHash
          .call(students, sort_by: params[:sort_by], lecture_id: params[:lecture])
      end
    end
  end
end

module Admin
  module Courses
    class ProgressController < BaseController
      helper_method :current_lecture, :students, :authenticate_lecturer!, :student_progress

      before_action :authenticate_lecturer!, only: :update

      breadcrumps do
        add :lectures_breadcrumb
        add :progress_breadcrumb
      end

      def update
        @progress = ::Courses::Progress.find(params[:id])
        react_to @progress.update(progress_params)
      end

      private

      def default_redirect
        redirect_to admin_courses_season_lecture_progress_index_path(current_season, current_lecture)
      end

      def current_lecture
        @lecture ||= ::Courses::Lecture.friendly.find(params[:lecture_id])
      end

      def students
        @students ||= ::Courses::Student.attending.includes(:user).where(season_id: current_season.id)
      end

      def lectures_breadcrumb
       add_breadcrumb 'courses.lectures.plural', path: admin_courses_season_lectures_path(current_season)
      end

      def progress_breadcrumb
        add_breadcrumb 'courses.progress.singular'
      end

      def authenticate_lecturer!
        current_lecture.mentor == ::Courses::Mentor.find_by(user_id: current_user.id)
      end

      def progress_params
        params.require(:progress).permit(:homework_mark, :lecture_presence)
      end

      def student_progress(lecture, student)
        student.progresses.find_by(lecture: lecture)
      end
    end
  end
end

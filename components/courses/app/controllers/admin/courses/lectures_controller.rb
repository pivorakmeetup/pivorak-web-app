module Admin
  module Courses
    class LecturesController < BaseController
      helper_method :lectures, :lecture, :venues, :mentors
      before_action :add_season_breadcrumb, :add_lectures_breadcrumb
      before_action :add_lecture_breadcrumb, only: %i[show edit update]
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]

      def new
        @lecture = current_season.lectures.build
        render_form
      end

      def create
        @lecture = current_season.lectures.new(lecture_params)
        react_to lecture.save
      end

      def update
        react_to lecture.update(lecture_params)
      end

      private

      def default_redirect
        redirect_to admin_courses_season_lectures_path
      end

      def lecture
        @lecture ||= ::Courses::Lecture.friendly.find(params[:id])
      end

      def lectures
        @lectures ||= Lecture::LecturesList.call(current_season)
      end

      def venues
        @venues ||= Venue.all
      end

      def mentors
        @mentors ||= Lecture::MentorsForLecture.call(current_season)
      end

      def add_lectures_breadcrumb
        add_breadcrumb 'courses.lectures.plural',
          path: admin_courses_season_lectures_path(current_season)
      end

      def add_lecture_breadcrumb
        add_breadcrumb lecture,
          path: admin_courses_season_lecture_path(current_season, lecture)
      end

      def lecture_params
        params.require(:lecture)
          .permit(:title, :started_at, :finished_at, :mentor_id,
            :venue_id, :description, :status)
      end
    end
  end
end

module Admin
  module Courses
    class LecturesController < ::Admin::Courses::BaseController
      helper_method :lectures, :lecture, :venues, :mentors

      breadcrumps do
        add :lectures_breadcrumb
        add :lecture_breadcrumb, only: %i[show edit update]
      end

      def new
        @lecture = current_season.lectures.build

        render_form
      end

      def create
        @lecture = current_season.lectures.new(lecture_params)

        react_to ::Courses::Lecture::Create.call(lecture)
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
        @lectures ||= current_season.lectures
                                    .includes(:venue)
                                    .includes(mentor: :user)
      end

      def venues
        @venues ||= ::Venue.all
      end

      def mentors
        @mentors ||= ::Courses::Lecture::MentorsForLecture.call(current_season)
      end

      def lectures_breadcrumb
        add_breadcrumb 'courses.lectures.plural',
          path: admin_courses_season_lectures_path(current_season)
      end

      def lecture_breadcrumb
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

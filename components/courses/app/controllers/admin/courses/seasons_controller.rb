module Admin
  module Courses
    class SeasonsController < ::Admin::Courses::BaseController
      helper_method :seasons, :season, :stat, :stat_locals

      before_action :add_season_breadcrumb, only: %i[show edit update]

      before_action :authenticate_mentor!,  only: %i[show edit update]

      def new
        @season = ::Courses::Season.new
        render_form
      end

      def create
        @season = ::Courses::Season.new(seasons_params)

        react_to ::Courses::Season::Create.call(season, current_user)
      end

      def update
        react_to season.update(seasons_params)
      end

      private

      def default_redirect
        redirect_to admin_courses_seasons_path
      end

      def season
        @season ||= ::Courses::Season.friendly.find(params[:id])
      end

      def seasons
        @seasons ||= ::Courses::Season::AllForCurrentMentor
          .call(current_user)
          .page(params[:page])
      end

      def stat_locals
        @stat_locals ||= {
            mentors: {
                name: t('courses.mentors.plural'),
                klass: 'green',
                quantity: stat[:mentors_count]
            },

            students: {
                name: t('courses.students.plural'),
                klass: 'teal',
                quantity: stat[:students_count]
            },

            students_attending: {
                name: t('courses.students.attending'),
                klass: 'orange',
                quantity: stat[:students_attending_count]
            },

            lectures: {
                name: t('courses.lectures.plural'),
                klass: 'red',
                quantity: stat[:lectures_count]
            }
        }
      end

      def stat
        @stat ||= {
            mentors_count:            ::Courses::Mentor.count,
            students_count:           ::Courses::Student.count,
            students_attending_count: ::Courses::Student.attending.count,
            lectures_count:           ::Courses::Lecture.count,
            students_by_status:       ::Courses::Student.group(:status).count
        }
      end

      def seasons_params
        params.require(:season).permit(:title, :start_at, :finish_at, :status)
      end
    end
  end
end

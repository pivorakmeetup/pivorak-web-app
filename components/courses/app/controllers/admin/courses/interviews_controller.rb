module Admin
  module Courses
    class InterviewsController < BaseController
      helper_method :interviews, :interview
      add_breadcrumb 'interviews.plural', :admin_courses_season_interviews_path
      before_action :set_season
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]

      def new
        @interview = @season.interviews.new
        render_form
      end

      def create
        @interview = @season.interviews.new(interviews_params)
        react_to interview.save
      end

      def update
        react_to interview.update(interviews_params)
      end

      private

      def set_season
        @season = ::Courses::Season.friendly.find(params[:season_id])
      end

      def default_redirect
        redirect_to admin_courses_season_interviews_path(@season)
      end

      def interview
        @interview ||= ::Courses::Interview.find(params[:id])
      end

      def interviews
        @interviews ||= @season.interviews.includes(:mentor).page(params[:page])
      end

      def interviews_params
        params.require(:interview).permit(:start_at, :description).merge(mentor_id: mentor_id)
      end

      def mentor_id
        ::Courses::Mentor.find_by(season_id: current_season.id, user_id: current_user.id).id
      end
    end
  end
end

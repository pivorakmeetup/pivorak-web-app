module Admin
  module Courses
    class SeasonsController < BaseController
      helper_method :seasons, :season

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

      def seasons_params
        params.require(:season).permit(:title, :start_at, :finish_at, :status)
      end
    end
  end
end

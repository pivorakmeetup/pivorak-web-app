module Admin
  module Courses
    class SeasonsController < BaseController
      helper_method :seasons, :season
      add_breadcrumb 'seasons.plural', :admin_courses_seasons_path
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]

      def new
        @season = ::Courses::Season.new
        render_form
      end

      def create
        @season = Season::Create.call(seasons_params)
        react_to season.save
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
      alias_method :current_season, :season


      def seasons
        @seasons ||= ::Courses::Season.page(params[:page])
      end

      def seasons_params
        params.require(:season).permit(:title, :start_at, :finish_at)
      end
    end
  end
end

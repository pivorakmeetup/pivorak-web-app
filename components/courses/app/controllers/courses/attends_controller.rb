module Courses
  class AttendsController < ::ApplicationController
    helper_method :current_season

    def create
    end

    private

    def default_redirect
    end

    def current_season
      @current_season ||= ::Courses::Season.friendly.find(params[:season_id])
    end

    def seasons_params
      params.require(:season).permit(:title, :start_at, :finish_at)
    end
  end
end

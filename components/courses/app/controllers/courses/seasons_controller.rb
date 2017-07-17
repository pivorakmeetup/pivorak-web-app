module Courses
  class SeasonsController < BaseController
    helper_method :season, :mentors

    private    

    def season
      @season ||= ::Courses::Season.friendly.find(params[:id])
    end

    def mentors
      season.mentors
    end
  end
end

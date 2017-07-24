module Courses
  class SeasonsController < BaseController
    helper_method :mentors, :season

    private

    def season
      @season ||= ::Courses::Season.friendly.find(params[:id])
    end

    def mentors
      @mentors ||= season.mentors.includes(:user)
    end

  end
end

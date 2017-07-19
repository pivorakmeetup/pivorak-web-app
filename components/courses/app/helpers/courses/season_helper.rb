module Courses
  module SeasonHelper
    def season_dates
      return unless season.start_at && season.finish_at

      "#{format_timestamp(season.start_at, time: false)} - #{format_timestamp(season.finish_at, time: false)}"
    end

    def season_links
      case season.status.to_sym
      when Courses::Season::REGISTRATION
        render 'courses/seasons/registration_season_links'
      when Courses::Season::LIVE
        render 'courses/seasons/live_season_links'
      end
    end
  end
end

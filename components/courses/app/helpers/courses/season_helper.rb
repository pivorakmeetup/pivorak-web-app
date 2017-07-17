module Courses
  module SeasonHelper
    def season_dates
      return unless season.start_at && season.finish_at

      "#{format_timestamp(season.start_at, time: false)} - #{format_timestamp(season.finish_at, time: false)}"
    end

    def season_links
      case season.status.to_sym
      when Courses::Season::REGISTRATION
        ("<p>#{link_to t('seasons.register'), '#'}</p>" +
          "<p>#{link_to t('seasons.send_test_task'), '#'}</p>").html_safe
      when Courses::Season::LIVE
        "<p>#{link_to t('seasons.send_homework'), '#'}</p>".html_safe
      end
    end
  end
end

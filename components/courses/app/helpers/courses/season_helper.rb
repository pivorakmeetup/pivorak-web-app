module Courses
  module SeasonHelper
    def season_dates
      return unless season.start_at && season.finish_at

      start_at = format_timestamp(season.start_at, time: false)
      finish_at = format_timestamp(season.finish_at, time: false)
      "#{start_at} - #{finish_at}"
    end

    def send_homework_link
      return unless season.status.to_sym == Courses::Season::LIVE

      link_to t('seasons.send_homework'), '#'
    end

    def register_link
      return unless season.status.to_sym == Courses::Season::REGISTRATION

      link_to t('seasons.register'), '#'
    end

    def send_test_task_link
      return unless season.status.to_sym == Courses::Season::REGISTRATION

      link_to t('seasons.send_test_task'), '#'
    end
  end
end

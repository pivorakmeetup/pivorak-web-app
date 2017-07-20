module Courses
  module SeasonHelper
    def courses_season_dates(season)
      return unless season.start_at && season.finish_at

      start_at = format_timestamp(season.start_at, time: false)
      finish_at = format_timestamp(season.finish_at, time: false)
      "#{start_at} - #{finish_at}"
    end

    def courses_send_homework_link(season)
      return unless season.status.to_sym == Courses::Season::LIVE

      link_to t('courses.seasons.send_homework'), '#'
    end

    def courses_register_link(season)
      return unless season.status.to_sym == Courses::Season::REGISTRATION

      link_to t('courses.seasons.register'), new_courses_season_student_path(season)
    end

    def courses_send_test_task_link(season)
      return unless season.status.to_sym == Courses::Season::REGISTRATION

      link_to t('courses.seasons.send_test_task'), '#'
    end
  end
end

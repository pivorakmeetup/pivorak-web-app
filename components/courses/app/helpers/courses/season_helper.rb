module Courses
  module SeasonHelper
    def courses_season_dates(season)
      return unless season.start_at && season.finish_at

      start_at = format_timestamp(season.start_at, time: false)
      finish_at = format_timestamp(season.finish_at, time: false)
      "#{start_at} - #{finish_at}"
    end

    def courses_send_homework_link(season, student)
      return unless ::Courses::Season::SendHomeworkPolicy.new(season, student).allowed?

      link_to t('courses.seasons.send_homework'),
        new_courses_season_homework_path(season)
    end

    def courses_register_link(season, student)
      return unless ::Courses::Season::RegisterPolicy.new(season, student).allowed?

      link_to t('courses.seasons.register'),
        new_courses_season_student_path(season)
    end

    def courses_send_test_task_link(season, student)
      return unless ::Courses::Season::SendTestTaskPolicy.new(season, student).allowed?

      link_to t('courses.seasons.send_test_task'),
        new_courses_season_test_task_path(season)
    end

    def courses_interviews_link(season, student)
      return unless ::Courses::Season::InterviewsPolicy.new(season, student).allowed?

      link_to t('courses.students.pick_interview_time'),
        courses_season_interviews_path(season)
    end
  end
end

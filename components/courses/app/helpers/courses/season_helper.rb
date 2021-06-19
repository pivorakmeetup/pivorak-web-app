# frozen_string_literal: true

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
              new_courses_season_homework_path(season),
              class: 'pk-btn pk-btn--medium'
    end

    def courses_register_link(season, student)
      return unless ::Courses::Season::RegisterPolicy.new(season, student).allowed?

      link_to t('courses.seasons.register'),
              new_courses_season_student_path(season),
              class: 'pk-btn pk-btn--medium'
    end

    def courses_send_test_task_link(season, student)
      return if season.open_format?
      return unless ::Courses::Season::SendTestTaskPolicy.new(season, student).allowed?

      if student.test_task
        label = t('courses.seasons.update_test_task')
        path = edit_courses_season_test_task_path(season)
      else
        label = t('courses.seasons.send_test_task')
        path = new_courses_season_test_task_path(season)
      end

      link_to label, path, class: 'pk-btn pk-btn--medium pk-btn--block pk-cources-seasons__send-task-btn'
    end

    def courses_interviews_link(season, student)
      return unless ::Courses::Season::InterviewsPolicy.new(season, student).allowed?

      link_to t('courses.students.pick_interview_time'),
              courses_season_interviews_path(season),
              class: 'pk-btn pk-btn--medium'
    end

    def courses_interviews_info(season, student)
      return unless ::Courses::Season::InterviewsPolicy.new(season, student).student_has_interview?

      t 'courses.interviews.picked_time',
        timeslot:    student.interview.start_at.strftime('%e %b - %H:%M'),
        description: student.interview.description
    end

    def courses_cancel_link(season, student)
      return if student.nil? || student.status.to_sym == Courses::Student::DROPPED ||
                student.status.to_sym == Courses::Student::GRADUATED ||
                student.status.to_sym == Courses::Student::REFUSED

      link_to t('courses.seasons.cancel'),
              courses_season_cancel_attendance_path(season),
              class:  'pk-btn pk-btn--link',
              method: :post,
              data:   {
                confirm: t('courses.students.confirm_cancel_attendance')
              }
    end
  end
end

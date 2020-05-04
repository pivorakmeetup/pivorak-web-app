# frozen_string_literal: true

module Courses
  class InterviewsController < BaseController
    helper_method :interview, :interviews
    before_action :execute_list_policy

    def update
      react_to ::Courses::Interview::Update.call(interview, current_student)
    end

    private

    def default_redirect
      redirect_to courses_season_path(current_season)
    end

    def interview
      @interview ||= ::Courses::Interview.find(params[:id])
    end

    def interviews
      @interviews ||= avaliable_timeslots.page(params[:page])
    end

    def avaliable_timeslots
      current_season.interviews
                    .where('start_at > ?', Time.current)
                    .attendance_available
    end

    def execute_list_policy
      allowed = Interview::ListPolicy.new(
        current_student, current_season
      ).allowed?
      return if allowed

      redirect_to courses_season_path(current_season),
                  alert: t('flash.courses.interviews.list.fail')
    end
  end
end

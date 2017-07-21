module Courses
  class InterviewsController < BaseController
    helper_method :interview, :interviews
    before_action :execute_list_policy

    def update
      if interview.update(student_id: current_student.id, status: :pending)
        flash_success and default_redirect
      else
        flash_error and default_redirect
      end
    end

    private

    def default_redirect
      redirect_to courses_season_path(current_season)
    end

    def interview
      @interview ||= ::Courses::Interview.find(params[:id])
    end

    def interviews
      @interviews ||= current_season.interviews
        .attendance_available
        .page(params[:page])
    end

    def interview_params
      params.require(:interview).permit(:student_id)
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

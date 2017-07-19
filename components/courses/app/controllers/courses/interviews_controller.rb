module Courses
  class InterviewsController < BaseController
    helper_method :interview, :interviews

    def update
      if interview.update(student_id: current_student.id)
        flash_success and default_redirect
      else
        flash_error and default_redirect
      end
    end

    private

    def default_redirect
      redirect_to root_path
    end

    def interview
      @interview ||= ::Courses::Interview.find(params[:id])
    end

    def interviews
      @interviews ||= current_season.interviews
        .includes(:mentor)
        .where(student_id: nil)
        .page(params[:page])
    end

    def interview_params
      params.require(:interview).permit(:student_id)
    end
  end
end

module Courses
  class InterviewsController < BaseController
    helper_method :interviews

    private

    def interviews
      @interviews ||= current_season.interviews
        .includes(:mentor)
        .where(student_id: nil)
        .page(params[:page])
    end
  end
end

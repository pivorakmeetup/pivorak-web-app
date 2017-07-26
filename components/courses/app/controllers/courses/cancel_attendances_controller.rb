module Courses
  class CancelAttendancesController < BaseController
    helper_method :courses_cancel_link
    before_action :authenticate_user!, only: %i[create new]

    def create
      ::Courses::Season::CancelAttendance.call(current_student)
      redirect_to courses_season_path(current_season)
    end
  end
end

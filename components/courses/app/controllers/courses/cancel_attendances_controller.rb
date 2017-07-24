module Courses
      class CancelAttendancesController < BaseController
      helper_method :courses_cancel, :current_student, :current_season, :cancel_link, :cancel_attendance
      before_action :authenticate_user!, only: %i[create new]


     / def create
      @current_student = current_student
      @current_student = Courses::Season.cancel_link
      flash.alert = 'Your participation has been cancelled successfully!'
    end/

      def create
        @cancel_attendance = ::Courses::CancelAttendance::Create.call(current_season, current_student)
        react_to cancel_attendance.save
      end



  end
end

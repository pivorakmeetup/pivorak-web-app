module Courses
  module Seasons
      class CancelAttendanceController < BaseController
      helper_method :courses_cancel, :current_student, :current_season, :cancel_link
      before_action :authenticate_user!, only: %i[create new]


      def create
      @current_student = current_student
      @current_student = Courses::Season.cancel_link
      flash.alert = 'Your participation has been cancelled successfully!'
    end

      def create
        @cancel_attendance = ::Courses::CancelAttendance::Create.call(current_season.id, current_student.id)
        react_to @cancel_attendance.save
      end

      def cancel_participation(season,student)
      if courses_cancel_link
        current_student.status == Courses::Season::Student.status(refused)
        react_to(save)
        redirect_to root_url
      end
    end
    end
  end
end

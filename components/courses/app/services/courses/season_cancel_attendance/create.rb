module Courses
  module Season
  class CancelAttendance
    class Create < ApplicationService
      def initialize(cancel_attendance)
        @cancel_attendance = cancel_attendance
      end

      def call
        if cancel_attendance.valid?
          cancel_attendance.save
          ::Courses::Student.destroy.each do |student|
            current_student.status == Courses::Season::Student.status(refused)
            react_to(save)
            redirect_to root_url
            end
        end
      end

      private

      attr_reader :lecture
    end
    end
  end
end

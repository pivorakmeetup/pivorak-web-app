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
          ::Courses::Student.each do |current_student|
            current_student.status == Courses::Season::Student.status(refused)
            react_to(save)
          end
        end
        redirect_to root_url
      end

      private
      attr_reader :cancel_attendance
    end
    end
  end
end

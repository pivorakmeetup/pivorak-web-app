module Courses
  class Lecture < ApplicationRecord
    class TimePolicy
      def initialize(lecture)
        @lecture = lecture
      end

      def allowed?
        time_is_correct?
      end

      private

      attr_reader :lecture

      def time_is_correct?
        lecture.started_at < lecture.finished_at
      end
    end
  end
end

module Courses
  class Interview
    class HasInterviewEarlierThanAllowedInterval

      def initialize(mentor, interview, interval)
        @mentor    = mentor
        @interview = interview
        @interval  = interval
      end

      def call
        interviews.any? && interviews.exclude?(self)
      end

      private

      def interviews
        @mentor.interviews.where(start_at: interview_start_time-interval_minutes..interview_start_time)
      end

      def interview_start_time
        @interview.start_at
      end

      def interval_minutes
        @interval.minutes
      end
    end
  end
end

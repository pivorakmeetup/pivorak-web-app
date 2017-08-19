module Courses
  class Interview < ApplicationRecord
    class IntervalPolicy

      def initialize(mentor, interview, interval)
        @mentor    = mentor
        @interview = interview
        @interval  = interval
      end

      def allowed?
        interview_start_time &&
          has_no_interviews_30_minutes_prior? &&
          has_no_interviews_30_minutes_after?
      end

      private

      attr_reader :mentor, :interview, :interval

      def has_no_interviews_30_minutes_prior?
        !(mentor_interviews
          .where(start_at:
          (interview_start_time - interval_minutes)...interview_start_time)
          .exists?)
      end

      def has_no_interviews_30_minutes_after?
        !(mentor_interviews
          .where(start_at:
          interview_start_time...(interview_start_time + interval_minutes))
          .exists?)
      end

      def mentor_interviews
        mentor.interviews.where.not(id: interview)
      end

      def interview_start_time
        interview.start_at
      end

      def interval_minutes
        interval.minutes
      end
    end
  end
end

# frozen_string_literal: true

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
          no_interviews_30_minutes_prior? &&
          no_interviews_30_minutes_after?
      end

      private

      attr_reader :mentor, :interview, :interval

      def no_interviews_30_minutes_prior?
        !mentor_interviews
          .exists?(start_at:
                             (interview_start_time - interval_minutes)...interview_start_time)
      end

      def no_interviews_30_minutes_after?
        !mentor_interviews
          .exists?(start_at:
                             interview_start_time...(interview_start_time + interval_minutes))
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

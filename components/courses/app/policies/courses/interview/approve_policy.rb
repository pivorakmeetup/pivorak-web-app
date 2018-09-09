module Courses
  class Interview < ApplicationRecord
    class ApprovePolicy
      def initialize(user, season, interview)
        @mentor = ::Courses::Mentor.find_by(user_id: user.id, season_id: season.id)
        @interview = interview
      end

      def allowed?
        current_user_interviewer? &&
          interview.completed? &&
          interview.student&.interviewing?
      end

      private

      attr_reader :mentor, :interview

      def current_user_interviewer?
        interview.mentor == mentor
      end
    end
  end
end

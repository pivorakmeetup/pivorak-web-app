module Courses
  class Student
    class CreatePolicy
      def initialize(user_id, season)
        @user_id = user_id
        @season = season
      end

      def allowed?
        has_no_applications?
      end

      private

      attr_reader :user_id, :season

      def has_no_applications?
        !(season.students.exists?(user_id: user_id))
      end
    end
  end
end

module Admin
  module Courses
    module Mentor
      class MentorPolicy
        def initialize(mentor, season)
          @mentor = mentor
          @season = season
        end

        def allowed_to_destroy?
          @mentor != @season.mentors.first
        end
      end
    end
  end
end

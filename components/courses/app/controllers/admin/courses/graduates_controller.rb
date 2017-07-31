module Admin
  module Courses
    class GraduatesController < ::Admin::Courses::BaseController
      def create
        ::Courses::Graduate::GraduateStudents.call(current_season)
        redirect_back(fallback_location: admin_courses_season_path(current_season))
      end
    end
  end
end

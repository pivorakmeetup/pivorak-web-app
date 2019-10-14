# frozen_string_literal: true

module Admin
  module Courses
    class GraduatesController < ::Admin::Courses::BaseController
      skip_before_action :execute_show_tab_policy

      def create
        ::Courses::Graduate::GraduateStudents.call(current_season)
        redirect_back(fallback_location: admin_courses_season_path(current_season))
      end
    end
  end
end

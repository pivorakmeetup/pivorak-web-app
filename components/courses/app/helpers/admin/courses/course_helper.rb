module Admin
  module Courses
    module CourseHelper
      def admin_courses_seasons_nav(&block)
        render layout: '/admin/courses/shared/nav' do
          yield
        end
      end

      def admin_courses_season_overview
        link_to t('courses.overview'),
          admin_courses_season_path(current_season),
          class: admin_courses_active_item?('seasons')
      end

      def admin_courses_season_mentors_link
        link_to t('mentors.plural'),
          admin_courses_season_mentors_path(current_season),
          class: admin_courses_active_item?('mentors')
      end

      def admin_courses_season_questions_link
        link_to t('questions.plural'),
          admin_courses_season_questions_path(current_season),
          class: admin_courses_active_item?('questions')
      end

      def admin_courses_season_interviews_link
        link_to t('interviews.plural'),
          admin_courses_season_interviews_path(current_season),
          class: admin_courses_active_item?('interviews')
      end

      def admin_courses_season_students_link
        link_to t('students.plural'),
          admin_courses_season_students_path(current_season),
          class: admin_courses_active_item?('students')
      end

      private

      def admin_courses_active_item?(ethalon_controller_name)
        if controller_name == ethalon_controller_name
          'active item'
        else
          'item'
        end
      end
    end
  end
end

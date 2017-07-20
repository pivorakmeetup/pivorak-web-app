module Admin
  module Courses
    module CourseHelper
      def admin_courses_seasons_nav(&block)
        render layout: '/admin/courses/shared/nav' do
          yield
        end
      end

      def admin_courses_season_overview
        link_to icon(:book, t('courses.overview')),
                admin_courses_season_path(current_season),
                class: admin_courses_active_item?('seasons')
      end

      def admin_courses_season_mentors_link
        link_to icon(:spy, t('courses.mentors.plural')),
                admin_courses_season_mentors_path(current_season),
                class: admin_courses_active_item?('mentors')
      end

      def admin_courses_season_questions_link
        link_to icon(:'help circle', t('courses.questions.plural')),
                admin_courses_season_questions_path(current_season),
                class: admin_courses_active_item?('questions')
      end

      def admin_courses_season_interviews_link
        link_to icon(:comments, t('courses.interviews.plural')),
                admin_courses_season_interviews_path(current_season),
                class: admin_courses_active_item?('interviews')
      end

      def admin_courses_season_students_link
        link_to icon(:student, t('courses.students.plural')),
                admin_courses_season_students_path(current_season),
                class: admin_courses_active_item?('students')
      end

      def admin_courses_season_lectures_link
        link_to icon(:university, t('courses.lectures.plural')),
                admin_courses_season_lectures_path(current_season),
                class: admin_courses_active_item?('lectures')
      end

      def admin_courses_season_test_task_index_link
        link_to icon(:github, t('test_task.plural')),
          admin_courses_season_test_task_index_path(current_season),
          class: admin_courses_active_item?('test_task')
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

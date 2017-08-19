module Admin
  module Courses
    module TestTaskHelper
      def approve_test_task_link(season, test_task)
        return "by #{test_task.mentor.full_name}" if test_task.mentor_id.present?

        link_to t('courses.test_tasks.approve'),
          admin_courses_season_test_task_path(season, test_task),
          method: :patch, class: 'ui button green',
          data: { confirm: t('phrases.confirm') }
      end
    end
  end
end

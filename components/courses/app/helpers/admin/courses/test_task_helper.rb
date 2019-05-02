# frozen_string_literal: true

module Admin
  module Courses
    module TestTaskHelper
      def courses_test_task_showcase_url(test_task)
        return t('words.none') unless test_task.showcase_url.present?

        link_to t('courses.test_task.show_url'), test_task.showcase_url
      end

      def courses_test_task_take_on_review_link(season, test_task)
        return unless test_task.submited?

        link_to t('courses.test_tasks.take_on_review'),
                admin_courses_season_test_task_path(season, test_task,
                                                    status: ::Courses::TestTask::ON_REVIEW),
                method: :put, class: 'ui button green',
                data: { confirm: t('phrases.confirm') }
      end

      def courses_test_task_take_off_review_link(season, test_task)
        return unless test_task.on_review? && test_task.mentor_id == current_mentor.id

        link_to t('courses.test_tasks.take_off_review'),
                admin_courses_season_test_task_path(season, test_task,
                                                    status: ::Courses::TestTask::SUBMITED),
                method: :put, class: 'ui button red',
                data: { confirm: t('phrases.confirm') }
      end

      def courses_test_task_review_by_info(test_task)
        return unless test_task.on_review?

        t('courses.test_tasks.by', name: test_task.mentor.full_name)
      end

      def courses_test_task_approve_link(season, test_task)
        return t('courses.test_tasks.by', name: test_task.mentor.full_name) if test_task.approved?
        return unless test_task.on_review? && test_task.mentor_id == test_task.mentor.id

        link_to t('courses.test_tasks.approve'),
                admin_courses_season_test_task_path(season, test_task,
                                                    status: ::Courses::TestTask::APPROVED),
                method: :put, class: 'ui button green',
                data: { confirm: t('phrases.confirm') }
      end
    end
  end
end

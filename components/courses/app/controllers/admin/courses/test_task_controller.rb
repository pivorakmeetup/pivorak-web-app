module Admin
  module Courses
    class TestTaskController < BaseController
      helper_method :test_tasks

      breadcrumps do
        add :test_tasks_breadcrumb
      end

      def update
        if ::Courses::TestTask::Update.call(test_task, current_mentor)
          flash_success and default_redirect
        else
          flash_error and default_redirect
        end
      end

      private

      def test_task
        @test_task ||= ::Courses::TestTask.find(params[:id])
      end

      def test_tasks
        @test_tasks ||= current_season.test_tasks.includes(student: :user).preload(mentor: :user)
      end

      def default_redirect
        redirect_to admin_courses_season_test_task_index_path
      end

      def test_tasks_breadcrumb
        add_breadcrumb 'courses.test_task.plural',
          path: admin_courses_season_test_task_index_path(current_season)
      end

      def add_test_tasks_breadcrumb
        add_breadcrumb 'test_tasks.plural',
          path: admin_courses_season_test_task_index_path(current_season)
      end
    end
  end
end

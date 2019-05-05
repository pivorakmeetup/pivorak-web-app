# frozen_string_literal: true

module Admin
  module Courses
    class TestTaskController < ::Admin::Courses::BaseController
      helper_method :test_tasks

      breadcrumps do
        add :test_tasks_breadcrumb
      end

      def update
        if ::Courses::TestTask::Update.call(test_task, current_mentor, test_task_update_params)
          flash_success && default_redirect
        else
          flash_error && default_redirect
        end
      end

      private

      def test_task
        @test_task ||= ::Courses::TestTask.find(params[:id])
      end

      def default_redirect
        redirect_to admin_courses_season_test_task_index_path
      end

      def test_tasks
        @test_tasks ||= ::Courses::TestTask::AllTestTasks.call(current_season)
      end

      def test_tasks_breadcrumb
        add_breadcrumb 'courses.test_task.plural',
                       path: admin_courses_season_test_task_index_path(current_season)
      end

      def add_test_tasks_breadcrumb
        add_breadcrumb 'test_tasks.plural',
                       path: admin_courses_season_test_task_index_path(current_season)
      end

      def test_task_update_params
        { status: params.dig(:test_task, :status), notes: params.dig(:test_task, :notes) }
      end
    end
  end
end

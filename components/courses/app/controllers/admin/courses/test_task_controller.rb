module Admin
  module Courses
    class TestTaskController < BaseController
      helper_method :test_tasks
      before_action :add_test_task_breadcrumb, :add_season_breadcrumb

      private

      def test_tasks
        @test_tasks ||= current_season.test_tasks.includes(student: :user)
      end
      def default_redirect
        redirect_to admin_courses_season_test_task_index_path
      end
      def add_test_task_breadcrumb
        add_breadcrumb 'test_task.plural', path: admin_courses_season_test_task_index_path(current_season)
      end
      def add_season_breadcrumb
        add_breadcrumb current_season, path: admin_courses_season_path(current_season)
      end
    end
  end
end

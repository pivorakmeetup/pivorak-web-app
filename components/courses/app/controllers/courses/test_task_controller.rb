# frozen_string_literal: true

module Courses
  class TestTaskController < BaseController
    helper_method :test_task, :test_tasks

    def create
      @test_task = ::Courses::TestTask::Create.call(test_task_params, current_student.id)

      if @test_task.save
        flash_success && default_redirect
      else
        flash_error && render(:new)
      end
    end

    def update
      if test_task.update(test_task_params)
        flash_success && default_redirect
      else
        flash_error && render(:edit)
      end
    end

    private

    def default_redirect
      redirect_to courses_season_path(current_season)
    end

    def test_task
      current_student.test_task || current_student.build_test_task
    end

    def test_task_params
      params.require(:test_task).permit(:git_url, :showcase_url, :comment)
    end
  end
end

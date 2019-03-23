module Courses
  class TestTaskController < BaseController
    helper_method :test_task, :test_tasks

    def new
      render_form
    end

    def edit
      render_form
    end

    def create
      @test_task = ::Courses::TestTask::Create.call(test_task_params, current_student.id)
      react_to test_task.save
    end

    def update
      react_to test_task.update(test_task_params)
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

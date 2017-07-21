module Courses
  class TestTaskController < BaseController
    helper_method :test_task
    before_action :authenticate_user!, only: %i[create new]

    def new
      @test_task = ::Courses::TestTask.new
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
      @test_task ||= ::Courses::TestTask.find(params[:id])
    end

    def test_task_params
      params.require(:test_task).permit(:git_url, :showcase_url, :comment)
    end
  end
end

module Courses
  class StudentsController < BaseController
    helper_method :student
    before_action :execute_create_policy

    def new
      @student = ::Courses::Student.new
      render_form
    end

    def create
      @student = Student::Create.call(student_params, current_season.id, current_user.id)
      react_to student.save
    end

    private

    def default_redirect
      redirect_to root_path
    end

    def student
      @student ||= ::Courses::Student.find(params[:id])
    end

    def execute_create_policy
      allowed =  Student::CreatePolicy.new(current_user.id, current_season).allowed?
      redirect_to root_path, alert: t('flash.courses.students.create.fail') unless allowed
    end

    def student_params
      params.require(:student).permit(:personal_info, :motivation_info)
    end
  end
end

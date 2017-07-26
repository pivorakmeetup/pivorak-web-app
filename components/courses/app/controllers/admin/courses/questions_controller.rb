module Admin
  module Courses
    class QuestionsController < ::Admin::Courses::BaseController
      helper_method :questions, :question

      breadcrumps do
        add :questions_breadcrumb
      end

      def new
        @question = ::Courses::Question.new
        render_form
      end

      def create
        @question = current_season.questions.new(questions_params)
        react_to question.save
      end

      def update
        react_to question.update(questions_params)
      end

      private

      def default_redirect
        redirect_to admin_courses_season_questions_path
      end

      def question
        @question ||= ::Courses::Question.find(params[:id])
      end

      def questions
        @questions ||= ::Courses::Question.where(season_id: current_season.id)
      end

      def questions_breadcrumb
        add_breadcrumb 'courses.questions.plural',
          path: admin_courses_season_questions_path(current_season)
      end

      def questions_params
        params.require(:question).permit(:body)
      end
    end
  end
end

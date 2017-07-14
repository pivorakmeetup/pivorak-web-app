module Admin
  module Courses
    class QuestionsController < BaseController
      helper_method :questions, :question
      before_action :add_season_breadcrumb, :add_question_breadcrumb

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

      def add_question_breadcrumb
       add_breadcrumb 'questions.plural', path: admin_courses_season_questions_path(current_season)
      end

      def questions_params
        params.require(:question).permit(:body)
      end
    end
  end
end

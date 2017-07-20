module Admin
  module Courses
    class QuestionsController < BaseController
      helper_method :questions, :question

      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]
      before_action :add_season_breadcrumb, :add_question_breadcrumb
      before_action :add_new_breadcump,  only: %i[new create]
      before_action :add_edit_breadcump, only: %i[edit update]

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
        add_breadcrumb 'courses.questions.plural',
          path: admin_courses_season_questions_path(current_season)
      end

      def questions_params
        params.require(:question).permit(:body)
      end
    end
  end
end

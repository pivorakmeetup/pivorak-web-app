module Admin
  module Courses
    module QuestionHelper
      def edit_question_link(question)
        link_to icon(:edit, t('words.edit')),
          edit_admin_courses_season_question_path(id: question.id),
          class: 'item'
      end

      def question_form_path(season, question)
        if question.new_record?
          admin_courses_season_questions_path(season)
        else
          admin_courses_season_question_path(season, question)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  module Courses
    module LectureHelper
      def edit_lecture_link(current_season, lecture)
        link_to icon(:edit, t('words.edit')),
                edit_admin_courses_season_lecture_path(current_season, lecture),
                class: 'item'
      end

      def lecture_form_path(season, lecture)
        if lecture.persisted?
          admin_courses_season_lecture_path(season, lecture)
        else
          admin_courses_season_lectures_path(season)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  module Courses
    module SeasonHelper
      def graduate_students_link(season)
        link_to t('courses.students.graduate'),
                admin_courses_season_graduate_path(season),
                method: :post, class: 'ui button green',
                data: { confirm: t('phrases.confirm') }
      end
    end
  end
end

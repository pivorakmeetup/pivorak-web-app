# frozen_string_literal: true

module Admin
  module Courses
    module StudentHelper
      def drop_student_link(season, student)
        return nil unless drop_policy(student).allowed?

        link_to t('courses.students.drop'),
                admin_courses_season_student_drop_path(season, student),
                method: :post, class: 'ui button red',
                data: { confirm: t('phrases.confirm') }
      end

      def drop_policy(student)
        ::Courses::Student::DropPolicy.new(student, total(student))
      end
    end
  end
end

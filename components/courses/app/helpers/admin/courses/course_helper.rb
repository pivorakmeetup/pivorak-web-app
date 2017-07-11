module Admin
  module Courses
    module CourseHelper
      def admin_courses_seasons_nav(&block)
        render layout: '/admin/courses/shared/nav' do
          yield
        end
      end

      def admin_season_mentors_link(season)
        link_to icon(:spy, t('mentors.plural')),
          admin_courses_season_mentors_path(season),
          class: 'item'
      end
    end
  end
end

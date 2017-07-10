module Admin
  module Courses
    module CourseHelper
      def admin_courses_seasons_nav(&block)
        render layout: '/admin/courses/shared/nav' do
          yield
        end
      end
    end
  end
end

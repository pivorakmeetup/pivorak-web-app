module Admin
  module Courses
    module MentorHelper
      def mentor_name(mentor)
        user = User.find(mentor.user_id)
        user.full_name
      end

      def remove_mentor_button(season, mentor)
        link_to icon(:trash, t('words.destroy')),
          admin_courses_season_mentor_path(season, mentor),
          method: :delete, class: 'item',
          data: { confirm: t('phrases.confirm') }
      end
    end
  end
end

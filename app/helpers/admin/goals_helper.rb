module Admin
  module GoalsHelper
    def admin_new_goal_link
      link_to t('phrases.new_resource', resource: t('goals.singular')),
        new_admin_goal_path,
        class: 'btn btn-success'
    end

    def admin_goal_link(goal)
      link_to goal.title, goal_path(goal), target: '_blank'
    end

    def admin_edit_goal_link(goal)
      link_to t('words.edit'), edit_admin_goal_path(goal)
    end
  end
end

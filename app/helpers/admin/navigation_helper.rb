module Admin
  module NavigationHelper
    ITEM = 'item'.freeze

    def sidebar_toogle_link
      link_to semantic_icon('align justify'), '#', data: { 'menu-toggle' => true }
    end

    def admin_app_link
      link_to t('words.app'), root_path, class: ITEM
    end

    def admin_home_link
      link_to t('admin.admin'), admin_path, class: class_for(:home)
    end

    def admin_events_link
      link_to t('events.plural'), admin_events_path, class: class_for(:events)
    end

    def admin_venues_link
      link_to t('venues.plural'), admin_venues_path, class: class_for(:venues)
    end

    def admin_talks_link
      link_to t('talks.plural'), admin_talks_path, class: class_for(:talks)
    end

    def admin_goals_link
      link_to t('goals.plural'), admin_goals_path, class: class_for(:goals)
    end

    def admin_members_link
      link_to t('members.plural'), admin_members_path, class: class_for(:members)
    end

    def admin_groups_link
      link_to t('groups.plural'), admin_groups_path, class: class_for(:groups)
    end

    def admin_emails_link
      link_to t('emails.plural'), admin_emails_path, class: class_for(:emails)
    end

    def admin_email_templates_link
      link_to t('email_templates.plural'), admin_email_templates_path, class: class_for(:email_templates)
    end

    def admin_friends_link
      link_to t('friends.plural'), admin_friends_path, class: class_for(:friends)
    end

    def admin_pages_link
      link_to t('pages.plural'), admin_pages_path, class: class_for(:pages)
    end

    private

    def class_for(item)
      [ITEM, active?(item)]
    end
  end
end

module Admin
  module NavigationHelper
    NAV_LINK_CLASS = 'nav-link'.freeze

    def admin_home_link
      link_to t('admin.admin'), admin_path, class: NAV_LINK_CLASS
    end

    def admin_events_link
      link_to t('events.plural'), admin_events_path, class: NAV_LINK_CLASS
    end

    def admin_venues_link
      link_to t('venues.plural'), admin_venues_path, class: NAV_LINK_CLASS
    end

    def admin_talks_link
      link_to t('talks.plural'), admin_talks_path, class: NAV_LINK_CLASS
    end

    def admin_goals_link
      link_to t('goals.plural'), admin_goals_path, class: NAV_LINK_CLASS
    end

    def admin_members_link
      link_to t('members.plural'), admin_members_path, class: NAV_LINK_CLASS
    end

    def admin_groups_link
      link_to t('groups.plural'), admin_groups_path, class: NAV_LINK_CLASS
    end

    def admin_app_link
      link_to t('words.app'), root_path, class: NAV_LINK_CLASS
    end

    def admin_emails_link
      link_to t('emails.plural'), admin_emails_path, class: 'nav-link'
    end
  end
end

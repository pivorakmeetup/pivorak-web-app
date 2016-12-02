module Admin
  module NavigationHelper
    def admin_home_link
      link_to t('admin.admin'), admin_path, class: 'nav-link'
    end

    def admin_events_link
      link_to t('events.plural'), admin_events_path, class: 'nav-link'
    end

    def admin_app_link
      link_to t('words.app'), root_path, class: 'nav-link'
    end
  end
end

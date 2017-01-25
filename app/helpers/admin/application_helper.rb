module Admin
  module ApplicationHelper
    ACTIVE = 'active'

    def active?(controller)
      ACTIVE if params[:controller].split('/').include?(controller.to_s)
    end

    def header_title
      controller = params[:controller].split('/').last
      controller == 'home' ?  t('admin.admin') : t(:plural, scope: controller)
    end

    def icon(icon, text = nil)
      "#{semantic_icon(icon)} #{text}".strip.html_safe
    end

    def controls(&block)
      render layout: '/admin/shared/controls' do
        yield
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  module EmailTemplatesHelper
    def email_preview_link(email_template)
      link_to 'Preview', email_template_preview_path(email_template), target: '_blank'
    end

    # rubocop:disable Layout/LineLength
    def email_template_preview_path(email_template)
      "/emails/en/#{email_template.title.split('#')[0].underscore}_preview-#{email_template.title.split('#')[1].underscore}"
    end
    # rubocop:enable Layout/LineLength
  end
end

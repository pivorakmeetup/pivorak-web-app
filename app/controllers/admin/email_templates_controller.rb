# frozen_string_literal: true

module Admin
  class EmailTemplatesController < BaseController
    helper_method :email_template, :email_templates
    add_breadcrumb 'email_templates.plural', :admin_email_templates_path
    before_action :add_edit_breadcump, only: %i[edit update]

    def edit
      render_form
    end

    def update
      if email_template.update(email_template_params)
        redirect_to edit_admin_email_template_path(email_template)
      else
        render_form
      end
    end

    private

    def email_template_params
      params.require(:email_template).permit(:subject, :body, :note)
    end

    def email_template
      @email_template ||= EmailTemplate.find(params[:id])
    end

    def email_templates
      @email_templates ||= EmailTemplate.order(:title)
    end
  end
end

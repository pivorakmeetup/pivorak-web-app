module Admin
  class EmailTemplatesController < BaseController
    helper_method :email_template, :email_templates
    add_breadcrumb 'email_templates.plural', :admin_email_templates_path

    def index

    end

    def edit
      render_form
    end

    def update
      email_template.update(email_template_params)
      redirect_to admin_email_templates_path
    end

    private

    def email_template_params
      params.require(:email_template).permit(:subject, :body)
    end

    def email_template
      @email_template ||= EmailTemplate.find(params[:id])
    end

    def email_templates
      @email_templates ||= EmailTemplate.all
    end
  end
end

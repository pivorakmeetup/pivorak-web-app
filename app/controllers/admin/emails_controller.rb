module Admin
  class EmailsController < BaseController
    helper_method :email, :emails
    add_breadcrumb 'emails.plural', :admin_emails_path
    before_action :add_new_breadcump,  only: %i[new create]

    def new
      render_form
    end

    def show
      add_breadcrumb email, label: :subject
    end

    def create
      @email = service.email

      respond_for service.call
    end

    private

    def default_redirect
      redirect_to([:admin, email])
    end

    def service
      @service ||= Email::Create.new(email_params)
    end

    def email_params
      params.require(:email).permit(:subject, :body)
    end

    def email
      @email ||= params[:id] ? Email.find(params[:id]) : Email.new
    end

    def emails
      @emails ||= search_against(Email).page(params[:page])
    end
  end
end

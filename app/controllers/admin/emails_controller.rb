module Admin
  class EmailsController < BaseController
    helper_method :email, :emails, :recipient_ids, :recipient_emails
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

      react_to service.call
    end

    private

    def recipient_ids
      params.fetch(:recipient_ids, [])
    end

    def recipient_emails
      @recipient_emails ||= User.where(id: recipient_ids).pluck(:email)
    end

    def default_redirect
      redirect_to([:admin, email])
    end

    def service
      @service ||= Email::Create.new(params: email_params, recipient_ids: recipient_ids)
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

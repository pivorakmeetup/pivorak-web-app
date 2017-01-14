module Admin
  class EmailsController < BaseController
    helper_method :email, :emails

    def create
      service = Email::Create.new(email_params)
      @email = service.email
      service.call ? redirect_to([:admin, email]) : render(:new)
    end

    private

    def email_params
      params.require(:email).permit(:subject, :body)
    end

    def email
      @email ||= if params[:id]
                   Email.find(params[:id])
                 else
                   Email.new
                 end
    end

    def emails
      @emails ||= Email.all
    end
  end
end

module Admin
  class MembersController < BaseController
    helper_method :member, :members, :url
    add_breadcrumb 'members.plural', :admin_members_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @member = User.new
      render_form
    end

    def create
      @member = User.new(users_params)

      respond_for User::Create.call(member, users_params, synthetic: true)
    end

    def update
      respond_for member.update_without_password(users_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_member_path(member)
    end

    def member
      @member ||= User.friendly.find(params[:id])
    end

    def members
      @members ||= search_against(User).order(:id).page(params[:page])
    end

    def users_params
      params.require(:member).permit(:email, :first_name, :last_name, :verified, :admin, :cover)
    end

    def url
      member.persisted? ? admin_member_path(member) : admin_members_path
    end
  end
end

module Admin
  class MembersController < BaseController
    helper_method :admin_members_list, :filter, :member, :members, :url
    add_breadcrumb 'members.plural', :admin_members_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @member = User.new
      render_form
    end

    def create
      @member = User.new(users_params)

      react_to User::Create.call(member, users_params, synthetic: true)
    end

    def update
      react_to member.update_without_password(users_params)
    end

    private

    def filter
      @filter ||= Filter::Member.new(filter_params)
    end

    def filtered_users
      User::Filtered.call(filter_params)
    end

    def filter_params
      params.fetch(:filter_member, {}).permit(Filter::Member::ATTRIBUTES)
    end

    def default_redirect
      redirect_to edit_admin_member_path(member)
    end

    def member
      @member ||= User.friendly.find(params[:id])
    end

    def members
      @members ||= search_against(filtered_users).order(:first_name, :last_name).page(params[:page])
    end

    def users_params
      params.require(:member).permit(:email, :first_name, :last_name, :verified, :admin, :cover)
    end

    def url
      member.persisted? ? admin_member_path(member) : admin_members_path
    end

    def admin_members_list
      @admin_members_list ||= User.admin
    end
  end
end

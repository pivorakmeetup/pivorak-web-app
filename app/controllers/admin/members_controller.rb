module Admin
  class MembersController < BaseController
    helper_method :member, :members

    def new
      @member = User.new
    end

    def create
      @member = User.new(users_params)

      if User::Create.call(member, users_params, synthetic: true)
        redirect_to admin_members_path
      else
        render :new
      end
    end

    def update
      if member.update_without_password(users_params)
        redirect_to admin_members_path
      else
        render :edit
      end
    end

    private

    def member
      @member ||= User.friendly.find(params[:id])
    end

    def members
      @members ||= User.order(:id)
    end

    def users_params
      params.require(:member).permit(:email, :first_name, :last_name)
    end
  end
end

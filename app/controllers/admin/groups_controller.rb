module Admin
  class GroupsController < BaseController
    helper_method :group, :groups

    def new
      @group = Group.new
    end

    def create
      @group = Group.new(groups_params)

      group.save ? redirect_to(admin_groups_path) : render(:new)
    end

    def update
      group.update(groups_params) ? redirect_to(admin_groups_path) : render(:edit)
    end

    def destroy
      group.destroy
      redirect_to admin_groups_path
    end

    private

    def group
      @group ||= Group.find(params[:id])
    end

    def groups
      @groups ||= Group.all
    end

    def groups_params
      params.require(:group).permit(:name, :resource)
    end
  end
end

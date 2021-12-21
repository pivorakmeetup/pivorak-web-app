# frozen_string_literal: true

module Admin
  class GroupsController < BaseController
    helper_method :group, :groups
    add_breadcrumb 'groups.plural', :admin_groups_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @group = Group.new
      render_form
    end

    def create
      @group = Group.new(groups_params)

      react_to group.save
    end

    def edit
      super
    end

    def update
      react_to group.update(groups_params)
    end

    def destroy
      react_to group.destroy
    end

    private

    def default_redirect
      redirect_to admin_groups_path
    end

    def group
      @group ||= Group.friendly.find(params[:id])
    end

    def groups
      @groups ||= Group.page(params[:page])
    end

    def groups_params
      params.require(:group).permit(:name, :resource)
    end
  end
end

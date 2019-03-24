# frozen_string_literal: true

module Admin
  class FriendsController < BaseController
    helper_method :friend, :friends
    add_breadcrumb 'friends.plural', :admin_friends_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @friend = Friend.new
      render_form
    end

    def create
      @friend = Friend.new(friend_params)

      react_to friend.save
    end

    def update
      react_to friend.update(friend_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_friend_path(friend)
    end

    def friend
      @friend ||= Friend.find(params[:id])
    end

    def friends
      @friends ||= search_against(Friend).includes(:group).order(:name).page(params[:page])
    end

    def friend_params
      params.require(:friend).permit(
        :name, :group_id, :logo, :link, :description, :published
      )
    end
  end
end

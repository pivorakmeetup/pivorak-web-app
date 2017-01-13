module Admin
  class FriendsController < BaseController
    helper_method :friend, :friends

    def new
      @friend = Friend.new
    end

    def create
      @friend = Friend.new(friend_params)

      if friend.save
        flash[:success] = t('notifications.success')
        default_redirect
      else
        render(:new)
      end
    end

    def update
      if friend.update(friend_params)
        flash[:success] = t('notifications.success')
        default_redirect
      else
        render(:edit)
      end
    end

    private

    def default_redirect
      redirect_to edit_admin_friend_path(friend)
    end

    def friend
      @friend ||= Friend.find(params[:id])
    end

    def friends
      @friends ||= Friend.order(:name)
    end

    def friend_params
      params.require(:friend).permit(
        :name, :group_id, :logo, :link, :description
      )
    end    
  end
end  

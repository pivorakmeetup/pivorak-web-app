module Admin
  class GoalsController < BaseController
    helper_method :goal, :goals
    add_breadcrumb 'goals.plural', :admin_goals_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @goal = Goal.new
      render_form
    end

    def create
      @goal = Goal.new(goal_params)

      respond_for goal.save
    end

    def update
      respond_for goal.update(goal_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_goal_path(goal)
    end

    def goal
      @goal ||= Goal.friendly.find(params[:id])
    end

    def goals
      @goals ||= Goal.all
    end

    def goal_params
      params.require(:goal).permit(:title, :description, :amount)
    end
  end
end

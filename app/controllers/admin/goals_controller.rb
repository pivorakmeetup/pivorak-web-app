module Admin
  class GoalsController < BaseController
    helper_method :goal, :goals

    def new
      @goal = Goal.new
    end

    def create
      @goal = Goal.new(goal_params)

      goal.save ? redirect_to(goal) : render(:new)
    end

    def update
      goal.update(goal_params) ? redirect_to(goal) : render(:edit)
    end

    private

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

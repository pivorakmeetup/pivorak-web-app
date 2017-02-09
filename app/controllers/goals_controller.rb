#
# Skip until 1.1 version
#
# class GoalsController < ApplicationController
#   helper_method :goal, :goals

#   def donate
#     result = Goal::Donations::Create.call(donation_params)

#     if result.success?
#       flash[:notice] = I18n.t('donations.success')
#     else
#       flash[:error] = result.message
#     end

#     redirect_to goal_path(goal)
#   end

#   private

#   def donation_params
#     credit_card_params.merge(user: current_user, goal: goal)
#   end

#   def credit_card_params
#     params.require(:credit_card).permit(:number, :cvc, :exp_month, :exp_year, :amount, :anonymous)
#   end

#   def goal
#     @goal ||= Goal.friendly.find(params[:id])
#   end

#   def goals
#     @goals ||= Goal.all
#   end
# end

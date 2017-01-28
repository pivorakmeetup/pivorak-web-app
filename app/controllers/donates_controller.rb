class DonatesController < ApplicationController
  helper_method :goal

  def create
    result = Goal::Donations::Create.call(donation_params)

    if result.success?
      flash[:notice] = I18n.t('donations.success')
    else
      flash[:error] = result.message
    end

    redirect_to donate_path
  end

  private

  def donation_params
    credit_card_params.merge(user: current_user, goal: goal)
  end

  def credit_card_params
    params.require(:credit_card).permit(:number, :cvc, :exp_month, :exp_year, :amount, :anonymous)
  end

  def goal
    @goal ||= Goal.first
  end
end

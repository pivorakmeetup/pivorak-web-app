class MembersController < ApplicationController
  helper_method :member

  private

  def member
    @member ||= User.find(params[:id])
  end
end

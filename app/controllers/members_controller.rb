class MembersController < ApplicationController
  helper_method :member, :members

  private

  def member
    @member ||= User.friendly.find(params[:id])
  end

  def members
    @members ||= User.all
  end
end

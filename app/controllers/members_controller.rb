class MembersController < ApplicationController
  helper_method :member, :members, :member_talks

  private

  def member_talks
    @member_talks ||= member.talks
  end

  def member
    @member ||= User.friendly.find(params[:id])
  end

  def members
    @members ||= User.all
  end
end

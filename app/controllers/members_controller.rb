class MembersController < ApplicationController
  disabled_feature_until '1.3'

  helper_method :member, :members, :member_talks, :visited_events

  private

  def member_talks
    @member_talks ||= member.talks
  end

  def visited_events
    @visited_events ||= Event::VisitedByUser.call(user_id: member.id)
  end

  def member
    @member ||= User.friendly.find(params[:id])
  end

  def members
    @members ||= User.all
  end
end

class SupportersController < ApplicationController
  helper_method :course_supporters, :meetups_supporters, :inlove_partner

  private

  def friends_groups
    @friends_groups ||= Group.friends
  end

  def course_supporters
    @course_supporters ||= friends_groups
      .find_by(name: 'Course')
      .friends
      .where.not(id: inlove_partner.id)
  end

  def meetups_supporters
    @meetups_supporters ||= friends_groups
      .find_by(name: 'meetups')
      .friends
      .where.not(id: inlove_partner.id)
  end

  def inlove_partner
    @inlove_partner ||= Friend.find_by(name: 'OnApp')
  end
end

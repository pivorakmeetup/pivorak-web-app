class SupportersController < ApplicationController
  helper_method :meetup_group, :course_group, :info_partners_group

  private

  def meetup_group
    @meetup_group ||= Group.find_by!(slug: 'meetups')
  end

  def course_group
    @course_group ||= Group.find_by!(slug: 'course')
  end

  def info_partners_group
    @info_partners_group ||= Group.find_by!(slug: 'info-partners')
  end
end

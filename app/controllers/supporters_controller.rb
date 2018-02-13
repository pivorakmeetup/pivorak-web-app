class SupportersController < ApplicationController
  helper_method :friends

  private

  def friends
    @friends ||= Friend.all
  end
end

class SupportersController < ApplicationController
  helper_method :friends

  private

  def friends
    @friends ||= Friend.published
  end
end

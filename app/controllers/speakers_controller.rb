class SpeakersController < ApplicationController
  helper_method :speakers

  private

  def speakers
    @speakers ||= User.joins(:talks)
  end
end

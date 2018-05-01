class SpeakersController < ApplicationController
  disabled_feature_until '1.3'

  helper_method :speakers

  private

  def speakers
    @speakers ||= User.joins(:talks)
  end
end

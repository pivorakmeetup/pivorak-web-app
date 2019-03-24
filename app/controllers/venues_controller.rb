# frozen_string_literal: true

class VenuesController < ApplicationController
  disabled_feature_until '1.3'

  helper_method :venue

  private

  def venue
    @venue ||= Venue.friendly.find(params[:id])
  end
end

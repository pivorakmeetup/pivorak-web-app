class VenuesController < ApplicationController
  helper_method :venue

  private

  def venue
    @venue ||= Venue.friendly.find(params[:id])
  end
end

class HomeController < ApplicationController
  helper_method :event

  def coming_soon
    render layout: 'coming_soon'
  end

  private

  def event
    @event ||= Event.potential_next
  end
end

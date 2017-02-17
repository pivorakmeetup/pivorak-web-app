class HomeController < ApplicationController
  def coming_soon
    render layout: 'coming_soon'
  end

  def index
    @event = Event.potential_next
  end
end

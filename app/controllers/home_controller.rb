class HomeController < ApplicationController
  def index
    upcoming_event = Event.upcoming

    if upcoming_event
      render 'events/show', locals: { event: upcoming_event }
    else
      render :index, locals: { event: Event.planned.last }
    end
  end
end

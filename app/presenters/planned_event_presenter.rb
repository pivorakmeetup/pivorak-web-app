# frozen_string_literal: true

class PlannedEventPresenter < BasePresenter
  presents :planned_event

  SOON_STRING = 'soon'

  def upcoming_date
    return SOON_STRING unless planned_event&.planned?

    started_at.strftime("#{started_at.day.ordinalize} of %B")
  end
end

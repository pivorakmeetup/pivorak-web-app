class AgendaController < ApplicationController
  helper_method :agenda

  def show; end

  private

  def event
    @event ||= Event.current.first!
  end

  def agenda
    MarkdownRenderer.call(event.agenda)
  end
end

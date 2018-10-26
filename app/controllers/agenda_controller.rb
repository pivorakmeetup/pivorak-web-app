class AgendaController < ApplicationController
  helper_method :agenda

  def show; end

  private

  def event
    Event.current || raise(ActiveRecord::RecordNotFound)
  end

  def agenda
    MarkdownRenderer.call(event.agenda)
  end
end

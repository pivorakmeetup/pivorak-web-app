# frozen_string_literal: true

class AgendaController < ApplicationController
  helper_method :agenda

  def show; end

  private

  def event
    Event.upcoming || raise(ActiveRecord::RecordNotFound)
  end

  def agenda
    MarkdownRenderer.call(event.agenda)
  end
end

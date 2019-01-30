# frozen_string_literal: true

class TalkPresenter < BasePresenter
  presents :talk

  EMPTY_URL = ''

  def speaker_cover_url
    speaker&.cover_url || EMPTY_URL
  end

  def speaker_full_name
    speaker&.full_name
  end

  def description
    MarkdownRenderer.call(talk.description)
  end
end
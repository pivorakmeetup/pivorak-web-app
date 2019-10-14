# frozen_string_literal: true

class MarkdownRenderer < ApplicationService
  def initialize(text)
    @text = text
  end

  def call
    markdown.render(text).html_safe
  end

  private

  attr_reader :text

  def markdown
    @markdown ||= ::Redcarpet::Markdown.new(renderer, extensions)
  end

  def renderer
    @renderer ||= ::Renderers::Code.new(render_options)
  end

  def render_options
    {
      filter_html: true,
      hard_wrap:   true
    }
  end

  def extensions
    {
      fenced_code_blocks: true,
      no_intra_emphasis:  true,
      autolink:           true,
      lax_html_blocks:    true,
      superscript:        true
    }
  end
end

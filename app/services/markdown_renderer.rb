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
    @markdown ||= ::Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def renderer
    @renderer ||= ::Redcarpet::Render::HTML.new(render_options = {autolink: true})
  end
end

module MarkdownHelper
  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, extensions = {})
  end

  def renderer
    @renderer ||= Redcarpet::Render::HTML.new(render_options = {autolink: true})
  end
end

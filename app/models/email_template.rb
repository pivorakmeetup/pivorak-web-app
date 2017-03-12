class EmailTemplate < ApplicationRecord
  def render(params = {})
    context = EmailContext.new(params)
    MarkdownRenderer.call context.instance_eval("\"" + body + "\"")
  end
end

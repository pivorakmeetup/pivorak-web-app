class EmailTemplate < ApplicationRecord
  validates :body, :subject, :title, presence: true

  def render(params = {})
    context = EmailContext.new(params)
    MarkdownRenderer.call context.instance_eval("\"" + body + "\"")
  end
end

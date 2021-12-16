# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  validates :body, :subject, :title, presence: true

  def render(params = {})
    context = EmailTemplate::EmailContext.new(params)
    MarkdownRenderer.call context.instance_eval("\"#{body}\"", __FILE__, __LINE__)
  end
end

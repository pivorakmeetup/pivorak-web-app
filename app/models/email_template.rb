class EmailTemplate < ApplicationRecord
  def render(params = {})
    context = Context.new(params)
    context.instance_eval(Slim::Engine.new.call body)
  end
end

class Context
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def default_url_options
    Rails.application.config.action_mailer[:default_url_options]
  end

  def initialize(args = {})
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end

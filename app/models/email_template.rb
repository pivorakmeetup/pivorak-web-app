class EmailTemplate < ApplicationRecord
  def render(params = {})
    context = Context.new(params)
    context.instance_eval(Slim::Engine.new.call body)
  end
end

class Context < ActionView::Base
  include Rails.application.routes.url_helpers
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  include ActionView::Helpers::UrlHelper

  def default_url_options
    Rails.application.config.action_mailer[:default_url_options]
  end

  def main_app
    self
  end

  def initialize(args = {})
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end

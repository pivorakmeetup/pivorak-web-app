# frozen_string_literal: true

module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published,     -> { where(published: true) }
    scope :not_published, -> { where(published: false) }
  end
end

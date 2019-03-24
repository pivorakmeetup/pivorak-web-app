# frozen_string_literal: true

class Friend < ApplicationRecord
  include ::Searchable
  include Publishable

  mount_uploader :logo, DefaultImageUploader

  belongs_to :group

  validates :name, :logo, presence: true
end

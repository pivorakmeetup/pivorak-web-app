class Talk < ApplicationRecord
  include ::Searchable
  include Publishable

  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :event
  belongs_to :speaker, class_name: 'User'
  belongs_to :group

  scope :sorted, -> { order(:title) }

  validates :title, presence: true
end

class Talk < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :event
  belongs_to :speaker, class_name: 'User'
  belongs_to :group

  validates :title, presence: true
end

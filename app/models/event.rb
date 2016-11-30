class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title,  presence: true
  validates :agenda, presence: true
end

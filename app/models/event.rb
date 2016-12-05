class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :talks

  validates :title,  presence: true
end

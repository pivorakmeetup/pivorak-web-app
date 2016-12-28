class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  DEFAULT_LIMIT = 50

  has_many :talks
  has_many :visit_requests

  validates :title,  presence: true
end

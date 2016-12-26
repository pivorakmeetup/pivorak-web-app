class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :talks
  has_many :visit_requests

  validates :title,  presence: true
end

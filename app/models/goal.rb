class Goal < ApplicationRecord
  include ::Searchable

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :donations, dependent: :destroy

  validates :title,  presence: true
  validates :amount, presence: true, numericality: true

  def achieved?
    donations_total >= amount
  end

  def donations_total
    donations.sum(:amount)
  end
end

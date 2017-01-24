class Page < ApplicationRecord
  validates :title, :url, :body, presence: true
  validates :url, uniqueness: true
end

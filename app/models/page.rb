class Page < ApplicationRecord
  include ::Searchable

  validates :title, :url, :body, presence: true
  validates :url, uniqueness: true
end

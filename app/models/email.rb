class Email < ApplicationRecord
  include ::Searchable

  validates :subject, :body, presence: true
end

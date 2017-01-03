class Email < ApplicationRecord
  validates :subject, :body, presence: true
end

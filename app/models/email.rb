class Email < ApplicationRecord
  include ::Searchable

  attr_accessor :recipients

  validates :subject, :body, presence: true
end

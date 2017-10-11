module Bb
  class Book < ApplicationRecord
    self.table_name = 'bb_books'

    enum status: { moderation: 0, verified: 1 }

    belongs_to :member

    validates :title, :description, presence: true
  end
end

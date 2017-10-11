module Bb
  class Member < ApplicationRecord
    self.table_name = 'bb_members'

    enum status: { knock: 0, verified: 1 }

    belongs_to :user

    has_many :books

    delegate :full_name, to: :user
    delegate :email,     to: :user
  end
end

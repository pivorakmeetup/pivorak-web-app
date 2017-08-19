module Bb
  class Member < ApplicationRecord
    self.table_name = 'bb_members'

    belongs_to :user

    delegate :full_name, to: :user
    delegate :email,     to: :user
  end
end

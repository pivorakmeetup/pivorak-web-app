module Authorization
  class User < ApplicationRecord
    self.table_name = :authorization_users

    scope :admin,     -> { where(admin: true) }
    scope :verified,  -> { where(verified:  true) }
    scope :newbies,   -> { where(verified:  false) }
    scope :synthetic, -> { where(synthetic: true) }
    scope :real,      -> { where(synthetic: false) }
  end
end

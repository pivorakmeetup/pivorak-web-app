module Authorization
  class User < ApplicationRecord
    self.table_name = :authorization_users
  end
end

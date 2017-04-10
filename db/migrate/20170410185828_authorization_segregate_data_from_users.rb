class AuthorizationSegregateDataFromUsers < ActiveRecord::Migration[5.0]
  class AuthorizationUser < ActiveRecord::Base;
    self.table_name = :authorization_users
  end

  def up
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO authorization_users (
        user_id,
        admin,
        verified,
        synthetic,
        created_at,
        updated_at
      )
      SELECT
        id,
        admin,
        verified,
        synthetic,
        created_at,
        updated_at
      FROM users
    SQL
  end

  def down
    AuthorizationUser.delete_all
  end
end

class ProfilingSegregateDataFromUsers < ActiveRecord::Migration[5.0]
  class ProfilingUser < ActiveRecord::Base;
    self.table_name = :profiling_users
  end

  def up
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO profiling_users (
        user_id,
        email,
        first_name,
        last_name,
        slug,
        cover,
        created_at,
        updated_at
      )
      SELECT
        id,
        email,
        first_name,
        last_name,
        slug,
        cover,
        created_at,
        updated_at
      FROM users
    SQL
  end

  def down
    ProfilingUser.delete_all
  end
end

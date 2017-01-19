class AddTokenToVisitRequests < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    add_column :visit_requests, :token, :uuid, index: true, default: 'uuid_generate_v4()'
  end
end

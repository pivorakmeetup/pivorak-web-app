# frozen_string_literal: true

class AddCheckedInAtToVisitRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :visit_requests, :checked_in_at, :datetime
  end
end

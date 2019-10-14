# frozen_string_literal: true

class AddVisitedToVisitRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :visit_requests, :visited, :boolean, default: false
  end
end

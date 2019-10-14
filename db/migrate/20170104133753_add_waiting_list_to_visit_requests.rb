# frozen_string_literal: true

class AddWaitingListToVisitRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :visit_requests, :waiting_list, :boolean, default: false
  end
end

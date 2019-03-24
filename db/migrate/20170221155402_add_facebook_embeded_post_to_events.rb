# frozen_string_literal: true

class AddFacebookEmbededPostToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :facebook_embeded_post, :text
  end
end

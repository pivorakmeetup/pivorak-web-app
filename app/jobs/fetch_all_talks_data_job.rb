# frozen_string_literal: true

class FetchAllTalksDataJob < ApplicationJob
  def perform(*)
    Talk::FetchExternalVideoData.fetch_all!
  end
end

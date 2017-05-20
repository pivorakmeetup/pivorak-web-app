class FetchAllTalksDataJob < ApplicationJob
  def perform(*)
    Talk::FetchExternalVideoData.fetch_all!
  end
end

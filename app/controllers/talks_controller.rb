class TalksController < ApplicationController
  helper_method :talks, :talk, :tags

  private

  def talk
    @talk ||= Talk.friendly.find(params[:id])
  end

  def talks
    @talks ||= search_against(Talk)
      .published
      .includes(:event)
      .page(params[:page])
      .sorted_by_date
  end

  def tags
    @tags ||= ActsAsTaggableOn::Tag.most_used
  end

  private

  def search_against(model)
    Search::Resource.call params.merge(model: model)
  end
end

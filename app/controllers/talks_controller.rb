class TalksController < ApplicationController
  helper_method :talks, :talk, :tags

  private

  def talk
    @talk ||= Talk.friendly.find(params[:id])
  end

  def talks
    return @talks if defined? @talks

    talks = search_against(Talk)
      .published
      .includes(:event, :speaker)
      .page(params[:page])
      .sorted_by_date

    @talks = params[:tag] ? talks.tagged_with(params[:tag]) : talks
  end

  def tags
    @tags ||= ActsAsTaggableOn::Tag.most_used
  end

  def search_against(model)
    Search::Resource.call params.merge(model: model)
  end
end

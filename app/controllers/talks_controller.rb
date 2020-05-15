# frozen_string_literal: true

class TalksController < ApplicationController
  helper_method :talks, :talk, :tags

  private

  def talk
    @talk ||= Talk.friendly.find(params[:id])
  end

  def talks
    @talks ||= params[:tag] ? untagged_talks.tagged_with(params[:tag]) : untagged_talks
  end

  def tags
    @tags ||= ActsAsTaggableOn::Tag.most_used
  end

  def search_against(model)
    Search::Resource.call params.merge(model: model)
  end

  def untagged_talks
    search_against(Talk)
      .published
      .assigned
      .includes(:event, :speaker)
      .page(params[:page])
      .sorted_by_date
  end
end

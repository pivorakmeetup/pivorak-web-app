class TalksController < ApplicationController
  helper_method :talks, :talk, :tags

  private

  def talk
    @talk ||= Talk.friendly.find(params[:id])
  end

  def talks
    scope = Talk.published.includes(:event)

    @talks ||= params[:tag] ? scope.tagged_with(params[:tag]) : scope
    @talks.page(params[:page]).per(12)
  end

  def tags
    @tags ||= ActsAsTaggableOn::Tag.most_used
  end
end

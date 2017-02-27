class TalksController < ApplicationController
  disabled_feature_until '1.1'

  helper_method :talks, :talk, :tags

  private

  def talk
    @talk ||= Talk.friendly.find(params[:id])
  end

  def talks
    scope = Talk.published

    @talks ||= params[:tag] ? scope.tagged_with(params[:tag]) : scope
  end

  def tags
    @tags ||= ActsAsTaggableOn::Tag.most_used
  end
end

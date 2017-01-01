class TalksController < ApplicationController
  helper_method :talks, :talk, :tags

  private

  def talk
    @talk ||= Talk.friendly.find(params[:id])
  end

  def talks
    @talks ||= if params[:tag]
                 Talk.tagged_with(params[:tag])
               else
                 Talk.all
               end
  end

  def tags
    @tags ||= ActsAsTaggableOn::Tag.most_used
  end
end

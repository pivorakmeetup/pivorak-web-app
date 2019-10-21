# frozen_string_literal: true

module TalksHelper
  def talks_tag_link(tag, options = {})
    link_to tag.name, talks_path(tag: tag.name), options
  end

  def talk_video_url(talk, talk_content, options = {})
    options[:target] = '_blank'

    return unless talk.video_url.present?

    link_to talk.video_url, options do
      talk_content
    end
  end

  def talk_slides_url(talk, options = {})
    options[:target] = '_blank'
    link_to 'Watch slides', talk.slides_url, options if talk.slides_url.present?
  end

  def talk_img(talk)
    "background-image: url(#{talk.cover_url})" if talk.cover_url.present?
  end

  def talk_link(talk, text = '', options = {})
    link_to text, polymorphic_path(talk), options
  end

  def talk_length(talk_duration)
    Time.at(talk_duration).utc.strftime('%H:%M:%S')
  end
end

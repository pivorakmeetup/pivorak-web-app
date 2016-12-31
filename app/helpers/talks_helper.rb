module TalksHelper
  def talks_tag_link(tag)
    link_to tag.name, talks_path(tag: tag.name)
  end
end

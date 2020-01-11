# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://pivorak.com'

SitemapGenerator::Sitemap.create do
  add events_path, priority: 0.7, changefreq: 'daily'
  Event.display.published.each do |event|
    add event_path(event), lastmod: event.updated_at
  end

  add talks_path, priority: 0.7, changefreq: 'daily'
  Talk.published.each do |talk|
    add talk_path(talk), lastmod: talk.updated_at
  end

  add speakers_path, priority: 0.7, changefreq: 'daily'
  add chat_path, priority: 0.7, changefreq: 'daily'
  add members_path, priority: 0.7, changefreq: 'daily'

  User.find_each do |member|
    add member_path(member), lastmod: member.updated_at
  end
end

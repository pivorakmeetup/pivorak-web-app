module PagesHelper
  def page_link(page, options = {})
    return unless page.persisted?

    link_to (options[:text] || page.title),
      "/#{page.url}", options.merge(target: '_blank')
  end
end

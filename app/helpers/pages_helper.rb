module PagesHelper
  def page_link(page, options = {})
    return unless page&.persisted?

    link_to options.fetch(:text, page.title),
      "/#{page.url}", options.merge(target: '_blank')
  end

  def preview_page_link(page)
    page_link page, text: t('words.preview'),
      class: 'ui button green', target: '_blank'
  end
end

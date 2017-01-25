module DryHelper
  def resource_link(resource, options = {})
    return unless resource.persisted?

    text_attr = options.delete(:text) || :title
    link_text = resource[text_attr] || text_attr

    link_to link_text, polymorphic_path(resource), options
  end
end

module DryHelper
  def resource_link(resource, options = {})
    link_text = options.delete(:text) || :title

    link_to resource.send(link_text),
      polymorphic_path(resource), options
  end
end

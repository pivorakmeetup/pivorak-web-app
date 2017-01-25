module Admin
  module DryHelper
    BOOL_BG_COLOR_CLASS = {
      true  => 'green',
      false => 'grey'
    }

    def admin_resources_link(resources, options = {})
      link_text = options.delete(:text) || t(:plural, scope: resources)

      link_to link_text, polymorphic_path([:admin, resources]), options
    end

    def admin_new_resource_link(resource_name)
      link_to icon(:add, t('phrases.new_resource', resource: t(:singular, scope: resource_name.to_s.pluralize))),
        new_polymorphic_path([:admin, resource_name]),
        class: 'ui button green'
    end

    def admin_edit_resource_link(resource)
      link_to icon(:edit, t('words.edit')),
        edit_polymorphic_path([:admin, resource]),
        class: 'item'
    end

    def admin_destroy_resource_link(resource)
      link_to icon(:trash, t('words.destroy')),
        polymorphic_path([:admin, resource]),
        method: :delete, class: 'item',
        data: { confirm: t('phrases.confirm') }
    end

    def resource_form_header(resource, label: :title)
      if resource.persisted?
        prefix = 'edit'
        label  = resource.send(label)
      else
        prefix = 'new'
        label  = resource.class
      end

      content_tag :h2 do
        t "phrases.#{prefix}_resource", resource: label
      end
    end

    def preview_link(resource)
      resource_link(resource, text: t('words.preview'),
        target: '_blank', class: 'ui button green')
    end

    def admin_back_link(resources_name)
      admin_resources_link(resources_name, text: t('words.back'),
        class: 'ui button grey')
    end

    def bool_icon(bool)
      content_tag :i, nil, class: ['circle icon', BOOL_BG_COLOR_CLASS[bool]]
    end
  end
end

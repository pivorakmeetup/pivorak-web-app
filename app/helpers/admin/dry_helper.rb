module Admin
  module DryHelper
    BOOL_BG_COLOR_CLASS = {
      true  => 'bg-success',
      false => 'bg-danger'
    }

    def admin_new_resource_link(resource_name)
      link_to t('phrases.new_resource', resource: t("#{resource_name.to_s.pluralize}.singular")),
        new_polymorphic_path([:admin, resource_name]),
        class: 'btn btn-success'
    end

    def admin_edit_resource_link(resource)
      link_to t('words.edit'), edit_polymorphic_path([:admin, resource]),
        class: 'btn btn-warning'
    end

    def admin_destroy_resource_link(resource)
      link_to t('words.destroy'), polymorphic_path([:admin, resource]),
        method: :delete, data: { confirm: t('phrases.confirm') },
        class: 'btn btn-danger'
    end

    def bool_label(bool)
      content_tag :span, t("words.is_#{bool}"),
        class: ['label label-bool', BOOL_BG_COLOR_CLASS[bool]]
    end
  end
end

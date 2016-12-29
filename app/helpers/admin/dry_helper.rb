module Admin
  module DryHelper
    def admin_new_resource_link(resource_name)
      link_to t('phrases.new_resource', resource: t("#{resource_name.to_s.pluralize}.singular")),
        new_polymorphic_path([:admin, resource_name]),
        class: 'btn btn-success'
    end

    def admin_edit_resource_link(resource)
      link_to t('words.edit'), edit_polymorphic_path([:admin, resource]),
        class: 'btn btn-warning'
    end
  end
end

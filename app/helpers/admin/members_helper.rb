module Admin
  module MembersHelper
    BOOL_BG_COLOR_CLASS = {
      true => 'bg-success',
      false => 'bg-danger'
    }

    def admin_new_member_link
      link_to t('phrases.new_resource', resource: t('members.singular')),
        new_admin_member_path,
        class: 'btn btn-success'
    end

    def admin_edit_member_link(member)
      link_to t('words.edit'), edit_admin_member_path(member)
    end

    def admin_member_link(member)
      link_to member.full_name, member_path(member), target: '_blank'
    end

    def member_synthetic_label(is_synthetic)
      content_tag :div, is_synthetic,
        class: ['label', BOOL_BG_COLOR_CLASS[is_synthetic]]
    end

    def member_verified_label(is_verified)
      content_tag :div, is_verified,
        class: ['label', BOOL_BG_COLOR_CLASS[is_verified]]
    end
  end
end

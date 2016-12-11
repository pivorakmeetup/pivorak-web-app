module Admin
  module MembersHelper
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
  end
end

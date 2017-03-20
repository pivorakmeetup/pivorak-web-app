module Admin
  module MembersHelper
    def admin_new_member_link
      link_to icon(:add, t('phrases.new_resource', resource: t('members.singular'))),
        new_admin_member_path,
        class: 'ui button green'
    end

    def admin_edit_member_link(member)
      link_to icon(:edit, t('words.edit')),
        edit_admin_member_path(member), class: 'item'
    end

    def admin_member_link(member)
      link_to member.full_name, member_path(member), target: '_blank'
    end

    def admin_squash_member_link(member)
      link_to icon(:compress, t('words.squash')),
        admin_member_squash_path(member), class: 'item'
    end
  end
end

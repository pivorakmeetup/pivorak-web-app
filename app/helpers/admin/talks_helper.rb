module Admin
  module TalksHelper
    NOT_ASSIGNED = I18n.t('phrases.not_assigned')
    EMPTY        = I18n.t('words.empty')

    def admin_new_talk_link
      link_to t('phrases.new_resource', resource: t('talks.singular')),
        new_admin_talk_path,
        class: 'btn btn-success'
    end

    def admin_talk_link(talk)
      link_to talk.title, talk_path(talk), target: '_blank'
    end

    def admin_edit_talk_link(talk)
      link_to t('words.edit'), edit_admin_talk_path(talk)
    end

    def admin_talk_event_link(talk)
      return NOT_ASSIGNED unless talk.event

      link_to talk.event.title, event_path(talk.event), target: '_blank'
    end

    def admin_talk_speaker_info(talk)
      speaker = talk.speaker

      return NOT_ASSIGNED if speaker.blank?
      return EMPTY if speaker.name.blank?

      talk.speaker.name
    end
  end
end

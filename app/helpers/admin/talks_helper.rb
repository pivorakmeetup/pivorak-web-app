# frozen_string_literal: true

module Admin
  module TalksHelper
    NOT_ASSIGNED = I18n.t('phrases.not_assigned')
    EMPTY        = I18n.t('words.empty')

    def admin_talk_event_link(talk)
      return NOT_ASSIGNED unless talk.event

      link_to talk.event.title, event_path(talk.event), target: '_blank', rel: 'noopener'
    end

    def admin_talk_speaker_info(talk)
      speaker = talk.speaker

      return NOT_ASSIGNED if speaker.blank?
      return EMPTY if speaker.full_name.blank?

      talk.speaker.full_name
    end
  end
end

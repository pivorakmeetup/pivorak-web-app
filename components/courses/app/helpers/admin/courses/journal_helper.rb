module Admin
  module Courses
    module JournalHelper
      def journal_mark(student, lecture)
        ::Courses::Journal::StudentMarkForLecture.call(student, lecture)
      end

      def journal_presence(student, lecture)
        presence = ::Courses::Journal::StudentPresenceForLecture
          .call(student, lecture)

        return nil if presence.zero? || presence.nil?
        presence
      end

      # TODO: move to css

      POSITIVE = '#e0ffe7'
      NEGATIVE = '#ffe8e0'
      WARNING  = '#fffde0'
      NEUTRAL  = '#ffffff'

      def courses_journal_data_color(value, mark = false)
        return NEUTRAL  if value.nil?
        return POSITIVE if value.positive?
        return NEGATIVE if value.negative?
        return WARNING  if value.zero? && mark

        NEUTRAL
      end

      def journal_value_id(student, lecture = nil, word = 'total')
        if lecture.nil?
          "s#{student.id.to_s}_#{word}"
        else
          "l#{lecture.id.to_s}_s#{student.id.to_s}_#{word}"
        end
      end
    end
  end
end

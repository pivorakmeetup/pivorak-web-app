# frozen_string_literal: true

module Admin
  module Courses
    module ProgressHelper
      LECTURE_ABSENT_MARK     = -1
      LECTURE_NOT_ABSENT_MARK = 0
      MINIMAL_MARK            = -1

      def homework_present?(lecture, student)
        ::Courses::Homework.exists?(lecture_id: lecture.id, student_id: student.id)
      end

      def homework_presence_icon(lecture, student)
        bool_icon(homework_present?(lecture, student))
      end

      def lecture_presence_icon(lecture, student)
        bool_icon(student_progress(lecture, student).lecture_presence == LECTURE_NOT_ABSENT_MARK)
      end

      def homework_git_link(lecture, student)
        return '-' unless homework_present?(lecture, student)

        homework = student.homeworks.find_by(lecture_id: lecture.id)
        link_to t('courses.progress.git'), homework.git_url, target: '_blank', rel: 'noopener'
      end

      def homework_showcase_link(lecture, student)
        return '-' unless homework_present?(lecture, student)

        homework = student.homeworks.find_by(lecture_id: lecture.id)
        return t('courses.progress.no_showcase') if homework.showcase_url.blank?

        link_to t('courses.progress.showcase'), homework.showcase_url
      end

      def set_lecture_presence(season, lecture, student) # rubocop:disable Metrics/MethodLength
        progress = student_progress(lecture, student)

        if progress.lecture_presence == LECTURE_NOT_ABSENT_MARK
          link_to t('courses.progress.absent'),
                  admin_courses_season_lecture_progress_path(
                    season,
                    lecture,
                    progress,
                    progress: { lecture_presence: LECTURE_ABSENT_MARK }
                  ),
                  method: :put, class: 'ui button red',
                  data: { confirm: t('phrases.confirm') }
        else
          link_to t('courses.progress.not_absent'),
                  admin_courses_season_lecture_progress_path(
                    season,
                    lecture,
                    progress,
                    progress: { lecture_presence: LECTURE_NOT_ABSENT_MARK }
                  ),
                  method: :put, class: 'ui button grey',
                  data: { confirm: t('phrases.confirm') }
        end
      end

      def homework_mark(lecture, student)
        student_progress(lecture, student).homework_mark
      end

      def set_mark_button(season, lecture, student, mark)
        return unless homework_present?(lecture, student) || mark == MINIMAL_MARK

        progress = student_progress(lecture, student)
        link_to mark.to_s,
                admin_courses_season_lecture_progress_path(season,
                                                           lecture,
                                                           progress,
                                                           progress: { homework_mark: mark }),
                method: :put, class: 'ui button',
                data: { confirm: t('phrases.confirm') }
      end
    end
  end
end

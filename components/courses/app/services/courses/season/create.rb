# frozen_string_literal: true

module Courses
  class Season < ApplicationRecord
    class Create < ApplicationService
      delegate :t, to: I18n

      def initialize(season, user)
        @season = season
        @user = user
      end

      def call
        return unless season.valid?

        transaction do
          default_questions.each do |default|
            season.questions.new(body: default)
          end

          season.mentors.new(user: user)

          season.save
        end
      end

      private

      attr_reader :season, :user

      def default_questions
        [
          t('courses.questions.default.first'),
          t('courses.questions.default.second'),
          t('courses.questions.default.third'),
          t('courses.questions.default.fourth'),
          t('courses.questions.default.fifth')
        ]
      end
    end
  end
end

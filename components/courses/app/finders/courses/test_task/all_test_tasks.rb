# frozen_string_literal: true

module Courses
  class TestTask < ApplicationRecord
    class AllTestTasks < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        season.test_tasks.includes(student: :user, mentor: :user)
      end

      private

      attr_reader :season
    end
  end
end

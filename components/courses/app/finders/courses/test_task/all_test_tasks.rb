module Courses
  class TestTask < ApplicationRecord
    class AllTestTasks < ApplicationFinder
      def initialize(season)
        @season = season
      end

      def call
        base_scope = season_test_tasks
                         .includes(student: :user)

        @test_tasks ||= if exists?
                          base_scope #.includes(mentor: :user)
                        else
                          base_scope
                        end
      end

      private

      attr_reader :season

      def exists?
        season_test_tasks.select { |test_task|
          !test_task.mentor_id.nil?
        }.any?
      end

      def season_test_tasks
        @season_test_tasks ||= season.test_tasks
      end
    end
  end
end

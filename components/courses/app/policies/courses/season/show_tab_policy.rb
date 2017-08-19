module Courses
  class Season < ApplicationRecord
    class ShowTabPolicy
      MENTORS    = ['mentors']
      QUESTIONS  = ['questions']
      STUDENTS   = ['students']
      TEST_TASKS = ['test_task']
      INTERVIEWS = ['interviews']
      LECTURES   = ['lectures']
      JOURNAL    = ['journal']

      def initialize(status, controller)
        @status     = status
        @controller = controller
      end

      def allowed?
        status_allows?
      end

      private

      attr_reader :status, :controller

      def allowed_tabs
        {
          Courses::Season::PLANNED      =>
            MENTORS + QUESTIONS,
          Courses::Season::REGISTRATION =>
            MENTORS + QUESTIONS + STUDENTS + TEST_TASKS,
          Courses::Season::SELECTION    =>
            MENTORS + STUDENTS + TEST_TASKS + INTERVIEWS,
          Courses::Season::LIVE         =>
            MENTORS + STUDENTS + LECTURES + JOURNAL,
          Courses::Season::PASSED       =>
            MENTORS + STUDENTS + TEST_TASKS + INTERVIEWS + LECTURES + JOURNAL
        }
      end

      def status_allows?
        allowed_tabs[status.to_sym].include?(controller)
      end
    end
  end
end

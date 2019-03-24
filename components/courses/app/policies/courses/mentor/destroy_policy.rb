# frozen_string_literal: true

module Courses
  class Mentor < ApplicationRecord
    class DestroyPolicy
      def initialize(mentor, season)
        @mentor = mentor
        @season = season
      end

      def allowed?
        mentor != season.mentors.first
      end

      private

      attr_reader :mentor, :season
    end
  end
end

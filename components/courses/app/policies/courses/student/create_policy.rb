# frozen_string_literal: true

module Courses
  class Student < ApplicationRecord
    class CreatePolicy
      def initialize(user_id, season)
        @user_id = user_id
        @season = season
      end

      def allowed?
        no_applications?
      end

      private

      attr_reader :user_id, :season

      def no_applications?
        !season.students.exists?(user_id: user_id)
      end
    end
  end
end

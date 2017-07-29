module Courses
  class Student < ApplicationRecord
    class Index < ApplicationService
      def initialize(season)
        @season = season
      end

      def call
        send "#{@season.status}_season_students".to_sym, @season
      end

      private

      attr_reader :season

      Courses::Season.statuses.keys.each do |status|
        define_method :"#{status}_season_students" do |season|
          "::Courses::Student::#{status.capitalize}Season".constantize.call(season)
        end
      end
    end
  end
end

module Admin
  module Courses
    module Season
      class Create
        def self.call(*args)
          new(*args).call
        end

        def initialize(seasons_params)
          @seasons_params = seasons_params
        end

        def call
          @season = ::Courses::Season.new(seasons_params)
          default_questions.each do |default|
            @season.questions.new(body: default)
          end
          @season
        end

        private

        attr_reader :seasons_params

        def default_questions
          default_questions = [
                                I18n.t('questions.default.first'),
                                I18n.t('questions.default.second'),
                                I18n.t('questions.default.third'),
                                I18n.t('questions.default.fourth'),
                                I18n.t('questions.default.fifth')
                              ]
        end
      end
    end
  end
end

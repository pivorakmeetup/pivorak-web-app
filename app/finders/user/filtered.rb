class User
  class Filtered < ApplicationFinder
    def initialize(params = {})
      @params = params
    end

    def call
      User.where(conditions)
    end

    private

    attr_reader :params

    def conditions
      params
        .except(:speaker)
        .keep_if { |_, value| parse_boolean(value) }
        .merge(speaker_condition || {})
    end

    def speaker_condition
      { id: User::Speakers.call } if parse_boolean(params[:speaker])
    end

    def parse_boolean(value)
      ActiveRecord::Type::Boolean.new.deserialize(value)
    end
  end
end

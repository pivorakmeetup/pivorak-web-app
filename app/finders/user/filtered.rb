# frozen_string_literal: true

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
      params.except(:speaker).merge(speaker_condition || {})
    end

    def speaker_condition
      { id: User::Speakers.call } if params.key?(:speaker)
    end
  end
end

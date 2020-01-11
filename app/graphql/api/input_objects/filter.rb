# frozen_string_literal: true

module Api
  module InputObjects
    class Filter < BaseInputObject
      argument :tags, [String], '', required: false
    end
  end
end

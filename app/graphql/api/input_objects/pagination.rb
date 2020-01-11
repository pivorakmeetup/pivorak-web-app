# frozen_string_literal: true

module Api
  module InputObjects
    class Pagination < BaseInputObject
      argument :offset, Integer, 'Data amount offset',              required: false
      argument :limit,  Integer, 'Per page data amount limitation', required: false
    end
  end
end

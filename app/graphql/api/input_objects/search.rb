# frozen_string_literal: true

module Api
  module InputObjects
    class Search < BaseInputObject
      argument :title, String, 'Title', required: false
    end
  end
end

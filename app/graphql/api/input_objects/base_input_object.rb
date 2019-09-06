# frozen_string_literal: true

module Api
  module InputObjects
    class BaseInputObject < GraphQL::Schema::InputObject
      argument_class Arguments::BaseArgument
    end
  end
end

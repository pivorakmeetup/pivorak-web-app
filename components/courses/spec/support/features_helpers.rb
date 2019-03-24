# frozen_string_literal: true

module Courses
  module Test
    module FeaturesHelpers
      #
      # Validation errors
      #
      def expect_an_error(hash_pair = {}, nope = false) # rubocop:disable Metrics/AbcSize
        field = hash_pair.keys.first
        value = hash_pair.values.first
        error_div = "div.#{field}.field_with_errors"

        msg = if value == :blank
                "can't be blank"
              elsif value == :has_been_taken
                'has already been taken'
              else
                value
              end

        to_or_not = nope ? :not_to : :to

        expect(page).send(to_or_not, have_css(error_div))

        return if nope

        expect(find(error_div.to_s)).send(to_or_not, have_content(msg))
      end

      def expect_not_an_error(hash_pair = {})
        expect_an_error(hash_pair, true)
      end

      #
      # Flash errors
      #
      def expect_success_flash_message(resource, action)
        expect(page).to have_content "#{resource} has been successfully #{action}"
      end

      # Error
      def expect_error_flash_message(resource, action)
        expect(page).to have_content "#{resource} cannot be #{action}. Please check the errors below"
      end
    end
  end
end

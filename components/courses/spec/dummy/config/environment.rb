# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true

Rails.application.initialize!



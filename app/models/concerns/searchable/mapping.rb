# frozen_string_literal: true

module Searchable
  module Mapping
    MAPPING = {
      user:          Configuration::User,
      event:         Configuration::Event,
      group:         Configuration::Group,
      talk:          Configuration::Talk,
      venue:         Configuration::Venue,
      page:          Configuration::Page,
      friend:        Configuration::Friend,
      email:         Configuration::Email,
      visit_request: Configuration::VisitRequest
    }.freeze
  end
end

# frozen_string_literal: true

Gibbon::Request.api_key        = ENV['MAILCHIMP_API_KEY']
Gibbon::Request.symbolize_keys = true
Gibbon::Request.debug          = Rails.env.development?

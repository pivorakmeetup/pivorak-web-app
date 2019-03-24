# frozen_string_literal: true

::Liqpay.configure do |config|
  config.public_key  = ENV['LIQPAY_PUBLIC_KEY']
  config.private_key = ENV['LIQPAY_PRIVATE_KEY']
end

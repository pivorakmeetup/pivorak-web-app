require 'wayforpay'

Wayforpay.configure do |config|
  config.merchant_account = ENV['WAY_FOR_PAY_MERCHANT_ACCOUNT'] # Seller identifier. This value is assigned to You from the side of WayForPay
  config.merchant_domain_name = ENV['WAY_FOR_PAY_MERCHANT_ACCOUNT']
  config.encrypt_secret_key = ENV['WAY_FOR_PAY_ENCRYPT_SECRET_KEY']
end

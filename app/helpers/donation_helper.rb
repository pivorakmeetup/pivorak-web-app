# frozen_string_literal: true

module DonationHelper
  def donation_form_data
    liqpay_request.data
  end

  def donation_form_signature
    liqpay_request.signature
  end

  def donation_form_url
    liqpay_request.url
  end

  private

  def liqpay_request
    Liqpay::Request::Base.call(user_id: current_user.try(:id))
  end
end

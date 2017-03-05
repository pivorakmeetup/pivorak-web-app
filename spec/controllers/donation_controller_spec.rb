require 'liqpay'

RSpec.describe DonationController do
  include Devise::Test::ControllerHelpers

  let(:valid_response)  { Base64.encode64((build :liqpay_valid_response_data).to_json) }
  let(:error_response)  { Base64.encode64((build :liqpay_error_response_data).to_json) }

  it 'valid donation' do
    post :create, params: { data: valid_response }

    expect(flash[:notice]).to eq(I18n.t('donations.success'))
    expect(Donation.count).to eq(1)
    expect(response).to redirect_to root_path
  end

  it 'error donation' do
    post :create, params: { data: error_response }

    expect(flash[:error]).to eq(I18n.t('liqpay.status.failure'))
    expect(Donation.count).to eq(0)
    expect(response).to redirect_to root_path
  end
end


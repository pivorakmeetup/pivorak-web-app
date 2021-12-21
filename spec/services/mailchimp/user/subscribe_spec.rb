# frozen_string_literal: true

RSpec.describe Mailchimp::User::Subscribe do
  let(:lists)    { double }
  let(:members)  { double }
  let(:user)     { create(:user) }
  let(:response) { described_class.call(user: user) }

  before do
    allow(Gibbon::Request).to receive(:lists).and_return(lists)
    allow(lists).to receive(:members) { members }
  end

  describe '.call' do
    context 'provided with valid input' do
      before { allow(members).to receive(:upsert) { Gibbon::Response.new } }

      it     { expect(response).to respond_to :body }
      it     { expect(response).to respond_to :headers }
    end

    context 'provided with invalid input' do
      before { allow(members).to receive(:upsert) { raise Gibbon::MailChimpError, 'Mailchimp Error' } }

      it     { expect { response }.not_to raise_error }
    end
  end
end

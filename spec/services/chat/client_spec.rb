# frozen_string_literal: true

require 'rails_helper'

describe Chat::Client do
  let(:url) { Faker::Internet.url }
  let(:response) { double('response', body: body) }
  before do
    expect_any_instance_of(HttpClient).to receive(:get).with(url, { token: ENV['SLACK_TOKEN'] }, {}) { response }
  end

  let(:client) { described_class.new(url: url) }

  describe '#call' do
    context 'when call is succesful' do
      let(:body) { { 'ok' => true }.to_json }

      it { expect(client.call).to be_truthy }
    end

    context 'when call is failure' do
      let(:error) { 'auth_error' }
      let(:body) { { 'error' => error }.to_json }

      it { expect { client.call }.to raise_error(Chat::Client::ChatError) }
    end
  end
end

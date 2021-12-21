# frozen_string_literal: true

require 'rails_helper'

describe Chat::Client do
  let(:url) { Faker::Internet.url }
  let(:response) { instance_double('response', body: body) }
  let(:client) { described_class.new(url: url) }

  before do
    stub_request(:get, url).with(query: { token: ENV['SLACK_TOKEN'] }).to_return(body: body)
  end

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

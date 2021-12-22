# frozen_string_literal: true

describe HttpClient do
  let(:http_client_service) { described_class.new }

  let(:url) { {} }
  let(:params) { {} }
  let(:headers) { {} }
  let(:http_client) { instance_spy(HTTPClient) }

  it 'responds to get/put/post/patch/delete' do
    allow(HTTPClient).to receive(:new).and_return(http_client)

    %i[get put post delete].each do |method|
      http_client_service.public_send(method, url, params, headers)
      expect(http_client).to have_received(method).with(url, params, headers)
    end
  end
end

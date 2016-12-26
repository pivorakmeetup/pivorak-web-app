describe HttpClient do
  subject { described_class.new }
  let(:url) { {} }
  let(:params) { {} }
  let(:headers) { {} }

  it 'responds to get/put/post/patch/delete' do
    [:get, :put, :post, :delete].each do |method|
      expect_any_instance_of(HTTPClient).to receive(method).with(url, params, headers)
      subject.public_send(method, url, params, headers)
    end
  end
end

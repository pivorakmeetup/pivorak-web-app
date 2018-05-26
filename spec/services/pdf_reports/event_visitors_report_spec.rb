RSpec.describe PdfReports::EventVisitorsReport do
  let(:first_user)  { create(:user, first_name: 'Alex') }
  let(:second_user)  { create(:user, first_name: 'Denys') }
  let(:third_user)  { create(:user, first_name: 'Petro') }
  let!(:first_visit_request)  { create(:visit_request, user: first_user) }
  let!(:second_visit_request)  { create(:visit_request, user: second_user) }
  let!(:third_visit_request)  { create(:visit_request, user: third_user) }
  let(:settings) { { columns: 2, font: :Courier, table: { cell_style: { size: 21 } } } }
  let(:service) { described_class.new(VisitRequest.all) }
  let(:text_inspector) { PDF::Inspector::Text.analyze(service.call.read) }
  let(:page_inspector) { PDF::Inspector::Page.analyze(service.call.read) }

  before { allow(service).to receive(:settings) { settings } }

  describe '.call' do
    context 'valid font styles' do
      it { expect(text_inspector.font_settings.first[:name]).to eq :Courier }
      it { expect(text_inspector.font_settings.first[:size]).to eq 21 }
    end

    context 'valid text' do
      it { expect(text_inspector.strings.to_a).to eq(['ALEX', 'DENYS', 'PETRO']) }
      it { expect(text_inspector.strings.size).to eq 3 }
    end

    context 'valid pages' do
      it { expect(page_inspector.pages.first[:strings]).to include('DENYS') }
      it { expect(page_inspector.pages.second[:strings]).to include('PETRO') }
      it { expect(page_inspector.pages.size).to eq 2 }
    end
  end
end

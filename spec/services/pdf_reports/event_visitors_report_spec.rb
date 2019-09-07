# frozen_string_literal: true

RSpec.describe PdfReports::EventVisitorsReport do
  let(:first_user) { create(:user, first_name: 'First', last_name: 'User') }
  let(:second_user) { create(:user, first_name: 'Second', last_name: 'User') }
  let(:third_user) { create(:user, first_name: 'Third', last_name: 'Long_user_last_name') }
  let!(:first_visit_request) { create(:visit_request, user: first_user) }
  let!(:second_visit_request) { create(:visit_request, user: second_user) }
  let!(:third_visit_request)  { create(:visit_request, user: third_user) }
  let(:settings) { { columns: 2, font: :Courier, table: { cell_style: { size: 21 } } } }
  let(:service) { described_class.new(VisitRequest.all) }
  let(:text_inspector) { PDF::Inspector::Text.analyze(service.call.read) }
  let(:page_inspector) { PDF::Inspector::Page.analyze(service.call.read) }

  before { allow(service).to receive(:settings) { settings } }

  describe '.call' do
    context 'valid font styles' do
      it { expect(text_inspector.font_settings.first[:name]).to eq settings[:font] }
      it { expect(text_inspector.font_settings.first[:size]).to eq settings.dig(:table, :cell_style, :size) }
    end

    context 'valid text' do
      it { expect(text_inspector.strings.first).to eq "1. #{first_user.full_name}" }
      it { expect(text_inspector.strings.last).to eq third_user.last_name }
      it { expect(text_inspector.strings.size).to eq 4 }
    end

    context 'valid pages' do
      it { expect(page_inspector.pages.first[:strings]).to include("1. #{first_user.full_name}") }
      it {
        expect(page_inspector.pages.second[:strings])
          .to contain_exactly("3. #{third_user.first_name}", third_user.last_name)
      }
      it { expect(page_inspector.pages.size).to eq 2 }
    end
  end
end

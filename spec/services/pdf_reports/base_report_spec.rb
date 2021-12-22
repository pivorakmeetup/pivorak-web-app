# frozen_string_literal: true

RSpec.describe PdfReports::BaseReport do
  let(:base_pdf_report) { described_class.new }

  describe '#generate_pdf' do
    it 'raise error' do
      expect { base_pdf_report.call }.to raise_error NotImplementedError
    end
  end

  describe '#settings' do
    it 'raise error' do
      expect { base_pdf_report.settings }.to raise_error Errno::ENOENT
    end
  end

  describe '#settings_file' do
    it 'has a valid file path' do
      expect(base_pdf_report.settings_file).to eq Rails.root.join('lib/pdf_reports/base_report.yml')
    end
  end

  describe '#report_options' do
    specify do
      expect(base_pdf_report.report_options).to eq({})
    end
  end
end

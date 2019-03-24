# frozen_string_literal: true

RSpec.describe PdfReports::BaseReport do
  subject { described_class.new }

  describe '#generate_pdf' do
    context 'raise error' do
      it { expect { subject.call }.to raise_error NotImplementedError }
    end
  end

  describe '#settings' do
    context 'raise error' do
      it { expect { subject.settings }.to raise_error Errno::ENOENT }
    end
  end

  describe '#settings_file' do
    context 'valid file path' do
      it { expect(subject.settings_file).to eq "#{Rails.root}/lib/pdf_reports/base_report.yml" }
    end
  end

  describe '#report_options' do
    context 'to be empty hash' do
      it { expect(subject.report_options).to eq({}) }
    end
  end
end

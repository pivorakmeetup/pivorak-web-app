# frozen_string_literal: true

module PdfReports
  class BaseReport < ::ApplicationService
    def call
      generate_pdf
      report_file
    end

    def generate_pdf
      raise NotImplementedError, 'For subclasses only!'
    end

    def report(&block)
      Prawn::Document.generate(report_file.path, report_options, &block)
    end

    def report_file
      @report_file ||= Tempfile.new([report_file_name.to_s, '.pdf'])
    end

    def report_file_name
      self.class.name.split('::').last.underscore
    end

    def settings
      @settings ||= YAML.load_file(settings_file).with_indifferent_access
    end

    def settings_file
      Rails.root.join("lib/pdf_reports/#{report_file_name}.yml")
    end

    def report_options
      @report_options ||= {}
    end
  end
end

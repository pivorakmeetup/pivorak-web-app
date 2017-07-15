module PdfReports
  class BaseReport < ::ApplicationService
    def call
      generate_pdf
      report_file
    end

    def generate_pdf
      fail NotImplementedError, 'For subclasses only!'
    end

    def report
      Prawn::Document.generate(report_file.path, report_options) do |pdf|
        yield(pdf)
      end
    end

    def report_file
      @report_file ||= Tempfile.new(["#{report_file_name}", '.pdf'])
    end

    def report_file_name
      self.class.name.split('::').last.underscore
    end

    def settings
      @settings ||= YAML.load_file(settings_file).with_indifferent_access
    end

    def settings_file
      File.expand_path("#{Rails.root}/lib/pdf_reports/#{report_file_name}.yml")
    end

    def report_options
      @report_options ||= {}
    end
  end
end

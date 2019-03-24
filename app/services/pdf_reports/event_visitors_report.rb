# frozen_string_literal: true

module PdfReports
  class EventVisitorsReport < BaseReport
    DEFAULT_FONT = 'Helvetica'

    def initialize(visit_requests)
      @visit_requests = visit_requests
    end

    def generate_pdf # rubocop:disable Metrics/AbcSize
      report do |pdf|
        pdf.font(settings.fetch(:font, DEFAULT_FONT))
        pdf.table(formated_data, settings.fetch(:table, {})) do |table|
          table.cells.width = pdf.bounds.width / settings.fetch(:columns, 1)
          table.cells.height = (pdf.bounds.height - 1) / settings.fetch(:rows, 1)
        end
      end
    end

    private

    attr_reader :visit_requests

    def formated_data
      @formated_data ||= visit_requests
                         .map { |vr| vr.user.full_name }
                         .sort
                         .each_slice(settings.fetch(:columns, 1)).to_a
    end

    def report_options
      @report_options ||= settings.fetch(:document, {}).merge(background: background)
    end

    def background
      # TODO: uncomment when badges template will be done
      # File.expand_path("#{Rails.root}/lib/pdf_reports/templates/event_visitors_background.jpg")
    end
  end
end

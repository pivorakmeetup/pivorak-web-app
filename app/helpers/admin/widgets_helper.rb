# frozen_string_literal: true

module Admin
  module WidgetsHelper
    def search_bar(path:)
      render 'admin/shared/search_bar', path: path
    end
  end
end

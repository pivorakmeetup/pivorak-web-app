# frozen_string_literal: true

module Renderers
  class Code < ::Redcarpet::Render::HTML
    def block_code(code, language)
      ::CodeRay.scan(code, language).div
    end
  end
end

# frozen_string_literal: true

module Shop
  class BaseController < ApplicationController
    before_action :authenticate_user!

    private

    def render_form
      render :form
    end

    def react_to(action)
      if action
        flash_success && default_redirect
      else
        flash_error && render_form
      end
    end
  end
end

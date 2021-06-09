# frozen_string_literal: true

module Shop
  class BaseController < ApplicationController
    before_action :authenticate_user!

    def current_order
      session[:order_id] ? Shop::Order.find(session[:order_id]) : []
    end

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

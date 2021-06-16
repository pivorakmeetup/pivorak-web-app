# frozen_string_literal: true

module Shop
  class BaseController < ApplicationController
    before_action :authenticate_user!

    helper_method :current_order

    def current_order
      return unless session[:order_id]

      @current_order ||= Shop::Order.find(session[:order_id])
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

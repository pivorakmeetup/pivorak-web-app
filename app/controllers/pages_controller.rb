# frozen_string_literal: true

class PagesController < ApplicationController
  helper_method :page

  def maintenance
    render 'maintainance/show', layout: 'maintenance'
  end

  private

  def page
    @page ||= Page.find_by!(url: params[:page_url])
  end
end

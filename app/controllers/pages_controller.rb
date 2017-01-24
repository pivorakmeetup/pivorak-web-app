class PagesController < ApplicationController
  helper_method :page

  def show
    page ? render(:show) : not_found
  end

  private

  def page
    @page ||= Page.find_by(url: params[:page_url])
  end
end

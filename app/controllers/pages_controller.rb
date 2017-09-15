class PagesController < ApplicationController
  helper_method :page

  private

  def page
    @page ||= Page.find_by!(url: params[:page_url])
  end
end

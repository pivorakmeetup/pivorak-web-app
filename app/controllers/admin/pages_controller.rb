# frozen_string_literal: true

module Admin
  class PagesController < BaseController
    helper_method :page, :pages
    add_breadcrumb 'pages.plural', :admin_pages_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @page = Page.new
      render_form
    end

    def create
      @page = Page.new(page_params)

      react_to page.save
    end

    def update
      react_to page.update(page_params)
    end

    def destroy
      page.destroy && redirect_to(admin_pages_path)
    end

    private

    def page
      @page ||= Page.find(params[:id])
    end

    def pages
      @pages ||= search_against(Page).page(params[:page])
    end

    def page_params
      params.require(:page).permit(:title, :body, :url)
    end

    def default_redirect
      redirect_to edit_admin_page_path(page)
    end
  end
end

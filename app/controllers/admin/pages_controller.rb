module Admin
  class PagesController < BaseController
    helper_method :page, :pages

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)

      page.save ? default_redirect : render(:new)
    end

    def update
      page.update(page_params) ?  default_redirect : render(:edit)
    end

    def destroy
      page.destroy and redirect_to(admin_pages_path)
    end

    private

    def page
      @page ||= Page.find(params[:id])
    end

    def pages
      @pages ||= Page.all
    end

    def page_params
      params.require(:page).permit(:title, :body, :url)
    end

    def default_redirect
      redirect_to edit_admin_page_path(page)
    end
  end
end

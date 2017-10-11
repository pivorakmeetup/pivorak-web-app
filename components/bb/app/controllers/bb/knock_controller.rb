module Bb
  class KnockController < BaseController
    before_action :execute_knock_policy

    helper_method :book, :first_book

    def new
      @book = Book.new
      render_form
    end

    def create
      @book = Book.new(book_params)

      if book.valid?
        Knock::Create.call(current_user, book)
        flash_success and default_redirect
      else
        render :form
      end
    end

    def destroy

    end

    private

    def default_redirect
      redirect_to bb_root_path
    end

    def first_book
      binding.pry # <====== REMOVE ME!!!
      @first_book ||= current_member&.books.first
    end

    def book
      @book ||= Book.find(params[:id])
    end

    def execute_knock_policy
      return if access_policy.can_knock?

      redirect_to bb_root_path
    end

    def book_params
      params.require(:book).permit(:title, :description)
    end
  end
end

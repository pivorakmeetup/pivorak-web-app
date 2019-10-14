# frozen_string_literal: true

module Admin
  module Members
    class SignInAsController < Members::BaseController
      def create
        sign_in(:user, member)
        redirect_to root_url
      end
    end
  end
end

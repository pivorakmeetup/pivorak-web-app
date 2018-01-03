module Users
  module Concerns
    module Recaptcha
      extend ActiveSupport::Concern

      included do
        attr_reader :recaptcha_error_message
        helper_method :recaptcha_error_message
      end

      private

      def check_captcha
        return if verify_recaptcha

        add_recaptcha_error
        self.resource = build_user
        resource.validate # Look for any other validation errors besides Recaptcha
        respond_with_navigational(resource) { render :new }
      end

      def add_recaptcha_error
        @recaptcha_error_message = flash[:recaptcha_error]
        flash.delete(:recaptcha_error)
      end

      def build_user
        resource_class.new(user_params)
      end

      # List of permitted params assigned to the User
      def user_params
        fail 'Should be implemented in the controller'
      end
    end
  end
end

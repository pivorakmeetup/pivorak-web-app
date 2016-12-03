module Admin
  module ApplicationHelper
    ACTIVE = 'active'

    def active?(*controllers)
      ACTIVE if controllers.map(&:to_s)
        .include?(params[:controller].split('/').last)
    end
  end
end

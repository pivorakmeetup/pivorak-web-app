module Admin
  class HomeController < BaseController
    helper_method :stat

    private

    def stat
      @stat ||= {
        events_by_status: Event.group(:status).count,
        users_by_months: User.group_by_month(:created_at).count,
        talks_by_months: Talk.group_by_month(:created_at).count,
        events_count: Event.count,
        users_count: User.count,
        talks_count: Talk.count
      }
    end
  end
end

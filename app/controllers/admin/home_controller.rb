module Admin
  class HomeController < BaseController
    helper_method :stat, :stat_locals

    private

    def stat_locals
      @stat_locals ||= {
        events: {
          name: 'Events',
          klass: 'green',
          quantity: stat[:events_count]
        },

        members: {
          name: 'Memebers',
          klass: 'teal',
          quantity: stat[:users_count]
        },

        speakers: {
          name: 'Speakers',
          klass: 'orange',
          quantity: stat[:speakers_count]
        },

        talks: {
          name: 'Talks',
          klass: 'blue',
          quantity: stat[:talks_count]
        }
      }
    end

    def stat
      @stat ||= {
        events_by_status:   Event.group(:status).count,
        users_by_months:    User.group_by_month(:created_at).count,
        talks_by_months:    Talk.group_by_month(:created_at).count,
        events_count:       Event.count,
        users_count:        User.count,
        talks_count:        Talk.count,
        speakers_count:     User::Speakers.call.count,
        visitors_per_event: Event::PerEventVisitors.call.count
      }
    end
  end
end

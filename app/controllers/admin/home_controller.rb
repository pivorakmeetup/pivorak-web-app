module Admin
  class HomeController < BaseController
    helper_method :stat, :stat_locals

    private

    def stat_locals
      @stat_locals ||= {
        events: {
          name: t('events.plural'),
          klass: 'green',
          quantity: stat[:events_count]
        },

        members: {
          name: t('members.plural'),
          klass: 'teal',
          quantity: stat[:users_count]
        },

        speakers: {
          name: t('speakers.plural'),
          klass: 'orange',
          quantity: stat[:speakers_count]
        },

        talks: {
          name: t('talks.plural'),
          klass: 'blue',
          quantity: stat[:talks_count]
        }
      }
    end

    def stat
      @stat ||= {
        events_by_status:   Event.group(:status).count,
        users_by_months:    Authentication::User::IncreasingPerMonth.call,
        talks_by_months:    Talk::IncreasingPerMonth.call,
        events_count:       Event.count,
        users_count:        User.count,
        talks_count:        Talk.count,
        speakers_count:     Profiling::User::Speakers.call.count,
        visitors_per_event: Event::PerEventVisitors.call.count
      }
    end
  end
end

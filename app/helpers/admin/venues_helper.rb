module Admin
  module VenuesHelper
    def admin_new_venue_link
      link_to t('phrases.new_resource', resource: t('venues.singular')),
        new_admin_venue_path,
        class: 'btn btn-success'
    end

    def admin_venue_link(venue)
      link_to venue.name, venue_path(venue), target: '_blank'
    end

    def admin_edit_venue_link(venue)
      link_to t('words.edit'), edit_admin_venue_path(venue)
    end
  end
end
module Admin
  class VenuesController < BaseController
    helper_method :venue, :venues
    add_breadcrumb 'venues.plural', :admin_venues_path
    before_action :add_new_breadcump,  only: %i[new create]
    before_action :add_edit_breadcump, only: %i[edit update]

    def new
      @venue = Venue.new
      render_form
    end

    def create
      @venue = Venue.new(venue_params)

      respond_for venue.save
    end

    def update
      respond_for venue.update(venue_params)
    end

    private

    def default_redirect
      redirect_to edit_admin_venue_path(venue)
    end

    def venue
      @venue ||= Venue.friendly.find(params[:id])
    end

    def venues
      @venues ||= Venue.all
    end

    def venue_params
      params.require(:venue).permit(:name, :description, :address, :map_url)
    end
  end
end

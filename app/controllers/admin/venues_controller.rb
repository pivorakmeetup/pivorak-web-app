module Admin
  class VenuesController < BaseController
    helper_method :venue, :venues

    def new
      @venue = Venue.new
    end

    def create
      @venue = Venue.new(venue_params)

      venue.save ? redirect_to(venue) : render(:new)
    end

    def update
      venue.update(venue_params) ? redirect_to(venue) : render(:edit)
    end

    private

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

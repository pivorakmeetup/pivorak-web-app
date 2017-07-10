module Admin
  module Courses
    class SeasonsController < BaseController
      # helper_method :event, :events, :venues
      add_breadcrumb 'seasons.plural', :admin_events_path
      #before_action :add_new_breadcump,  only: %i[new create]
      #before_action :add_edit_breadcump, only: %i[edit update]
    end
  end
end

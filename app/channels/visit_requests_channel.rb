class VisitRequestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "visit_requests_#{params[:event_id]}_channel"
  end
end

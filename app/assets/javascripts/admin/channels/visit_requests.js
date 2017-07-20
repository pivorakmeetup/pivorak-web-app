var VisitRequests = {
  actionCableInit: function() {
    $(document).on('turbolinks:load', this.actionCableCreate);
  },

  actionCableCreate: function() {
    var event_id = document.querySelector('#event').getAttribute('data-event-id');

    App.visit_requests = App.cable.subscriptions.create(
      {
        channel: 'VisitRequestsChannel',
        event_id: event_id
      },
      {
        received: function(data) {
          var visitRequest = document.querySelector('#visit-request-' + data['visit_request_id']);

          visitRequest.innerHTML = data['partial'];
      }
    });
  }
}

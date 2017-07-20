// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require jquery
//= require tether.min
//= require jquery_ujs
//= require semantic-ui
//= require semantic-ui-calendar
//= require admin/semantic
//= require simplemde.min
//= require Chart.bundle
//= require chartkick
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  var SIMPLEMDE_CONTAINER_CLASS = "simplemde-container"; // add this class to text area
  Array.prototype.forEach.call(document.getElementsByClassName(SIMPLEMDE_CONTAINER_CLASS), function(element) {
    new SimpleMDE({ element: element });
  });

    // when checkboxes are checked - submit form
    var submitOnClickForm = document.getElementsByClassName('js-submit-on-click-form')[0];
    if(submitOnClickForm) {
        var inputs = submitOnClickForm.getElementsByTagName("input");
        [].forEach.call(inputs, function(input){
            input.addEventListener('click', submitForm);
        });
    }

    function submitForm(event) {
        event.target.form.submit();
    }

  var dateTime = document.querySelectorAll('.date-time-picker');
  for(var i = 0; i < dateTime.length; i++) {
    $(dateTime[i]).calendar({
      disableMinute: true
    });
  }
})


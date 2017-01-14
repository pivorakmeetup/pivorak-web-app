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
// for bootstrap tooltips
//= require tether.min
//= require bootstrap-sprockets
//= require jquery_ujs
//= require simplemde.min
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require_tree .

document.addEventListener("turbolinks:load", function() {
    var SIMPLEMDE_CONTAINER_CLASS = "simplemde-container"; // add this class to text area
    Array.prototype.forEach.call(document.getElementsByClassName(SIMPLEMDE_CONTAINER_CLASS), function(element) {
        new SimpleMDE({ element: element });
    });
})

document.addEventListener('DOMContentLoaded', function() {
    UnobtrusiveFlash.flashOptions['timeout'] = 3000;
})




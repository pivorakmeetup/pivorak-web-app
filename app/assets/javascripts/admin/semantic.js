//
// Yes... this is jQuery code :(
//
document.addEventListener("turbolinks:load", function() {
  // Sidebar toggle button
  $('[data-menu-toggle="true"]').click(function(e) {
    e.preventDefault();

    $('.ui.sidebar').sidebar('toggle');
  });

  // Dropdown
  $('.ui.dropdown').dropdown();

  // Forms
  $('select').dropdown();
  $('.ui.checkbox').checkbox();

  // Flash message
  $('.message .close')
  .on('click', function() {
    $(this).closest('.message').transition('fade');
  })
;
})

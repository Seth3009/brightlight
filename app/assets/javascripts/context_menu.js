$(document).on("ready page:load page:change", function(){
  var toggle_menu = function() {
    $('.context-buttons').toggle($('input.checkbox:checked').length > 0);
    $('.nav-menu').toggle($('input.checkbox:checked').length == 0);   
  };

  var toggle_checkbox = function() {
    toggle_menu();
    $(".allcheckboxes").prop("checked", $('input.checkbox').length == $('input.checkbox:checked').length);
  }

  $(".checkbox").on("change", toggle_checkbox.bind(this));

  $(document).on("change", ".allcheckboxes", function(e) {
    $(".checkbox").prop("checked", $(e.target).prop("checked"));
    toggle_menu();
  }.bind(this));
});

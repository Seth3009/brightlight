var ready;
ready = function(){
  if ($("body.book_copies").length == 0) return;
  var toggle_menu = function() {
    $('.context-buttons').toggle($('input.checkbox:checked').length > 0);
    $('.nav-menu').toggle($('input.checkbox:checked').length == 0);      
  };
  var toggle_checkbox = function() {
    toggle_menu();
    $(".allcheckboxes").prop("checked", $('input.checkbox').length == $('input.checkbox:checked').length);
  }
  $(".checkbox").on("change", toggle_checkbox.bind(this));
  $(".card-panel").on("change", ".allcheckboxes", function(e) {
    $(".checkbox").prop("checked", $(e.target).prop("checked"));
    toggle_menu();
  }.bind(this));
};
$(document).on("ready", ready);
$(document).on("page:load", ready);
$(document).on("page:change", ready);
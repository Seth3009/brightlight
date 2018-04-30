$(document).on("ready page:load page:change", function(){
  if ($("body.book_copies").length == 0) return;
  let toggle_menu = function() {
    $('.context-buttons').toggle($('input.checkbox:checked').length > 0);
    $('.nav-menu').toggle($('input.checkbox:checked').length == 0);      
  };
  let toggle_checkbox = function() {
    toggle_menu();
    $(".allcheckboxes").prop("checked", $('input.checkbox').length == $('input.checkbox:checked').length);
  }
  $(".checkbox").on("change", toggle_checkbox.bind(this));
  $(".card-panel").on("change", ".allcheckboxes", function(e) {
    $(".checkbox").prop("checked", $(e.target).prop("checked"));
    toggle_menu();
  }.bind(this));
});


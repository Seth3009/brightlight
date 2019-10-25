$(document).on('ready page:load', function () {
  $(document).on("click", "input.checkbox.toggle-trigger", function(event) {
    var checked = $("input.checkbox:checked").length;
    if (checked > 0) {
      $(".check-togglable").prop("disabled", false);
    } else {
      $(".check-togglable").prop("disabled", true)
    }
  });
});
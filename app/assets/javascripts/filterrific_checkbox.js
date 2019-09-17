$(document).on('page:load ready', function(){
  function update_checkboxes(){
    $("[name^='add']").prop('checked', $("#add_all").is(":checked")); 
  };
  $("#add_all").change(update_checkboxes); 
  $('#filterrific_filter').on("change", ":input", function(){
    $(document).on('change', "#add_all", update_checkboxes);
  });
});

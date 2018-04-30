$(document).on "click", ".mark-read", -> 
  msgid = $(this).data("id")
  $("#msgrec-"+msgid).hide()
  $.ajax
    url:    "/messages/"+msgid+"/mark_read/",
    data:   {user_id: $(this).data("recipient")},
    method: 'post',
    success: (response) ->
      $(".inbox-badge").html(response["unread"])
      $(".inbox-badge").hide() if response["unread"] == 0

    


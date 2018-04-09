$(document).on("ready page:load", function(){
  $("#scan-modal").codeScanner({
    minEntryChars: 9,
    maxEntryTime: 200,
    onScan: function($element, input) {
      console.log("Scanning");
      create_entry($element, input);
      $("#scan-modal").closeModal();
    }
  });
  function create_entry(el, input) {
    let dataToSend = new Object();
    // dataToSend = { badge: { code: input }};
    var jsonData = JSON.stringify(dataToSend);
    console.log("SCAN", el, input);
    /*
    $.ajax({
      type: 'POST',
      contentType: "application/json; charset=utf-8",
      url: url,
      data: jsonData,
      dataType: 'json'
    })
    .done(function(m) {
      Materialize.toast('Smartcard registered', 5000, 'green');
    })
    .fail(function(e) {        
      Materialize.toast('Smartcard registration error', 5000, 'red');
    });  
    */
  };
});

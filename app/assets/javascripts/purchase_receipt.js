$(document).on('page:load ready', function() {
  $(window).codeScanner({
    minEntryChars: 10,
    maxEntryTime: 500,
    onScan: function($element, input) {             
      var card = input.trim();     
      $.ajax({
        url: "/purchase_receives/check.js?code="+card
      })        
    }
  });
});
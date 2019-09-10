// Handles ID scan for gate access log
$(document).on("ready page:load page:change", function() { 
  $("#access-log").codeScanner({
    minEntryChars: 9,
    onScan: function($element, input) {
      var badgeId = input.trim();
      var location = $("#room").data("location")
      var dataToSend = { ip: $("#room").data("ip"), id: badgeId };
      var jsonData = JSON.stringify(dataToSend);
      var url = "/api/tap";
      console.log("DATA", jsonData);
      $.ajax({
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        url: url,
        data: jsonData,
        dataType: 'json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader('Authorization', 'Token token=f088695c5361be3b79079703e5a1b78c');
        },
      })
      .success(function(data) {
        var time = new Date;
        console.log("SUCCESS", data);
        $("tbody#access-log").prepend("<tr><td>"+time.toLocaleDateString()+" "+time.toLocaleTimeString()+"</td><td>"+location+"</td><td>"+data.code+"</td><td>"+data.name+"</td><td>"+data.kind+"</td></tr>");
      })
      .error(function(xhr) {
        Materialize.toast('ID not recognized', 5000, 'red');
        console.log(xhr);
      });               
    }
  });
});


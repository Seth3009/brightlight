/* Carpool */


function carpool_scanner(el,barcode) {
  url = "/carpools";
  var dataToSend = new Object();
  dataToSend = { carpool: { barcode: barcode }};
  var jsonData = JSON.stringify(dataToSend);
  $.ajax({
    type: 'POST',
    contentType: "application/json; charset=utf-8",
    url: url,
    data: jsonData,
    dataType: 'json',
    success: function(data) {
      var car = data.carpool;
      Materialize.toast('Welcome! '+car.id+'-'+car.transport_name, 5000, 'green');
      update_carpool_info(car);
      localStorage.carpool_mark = (Date.parse(car.created_at)/1000) >> 0;
    },
    error: function() {
      Materialize.toast('Error: invalid barcode', 5000, 'red');
    }
  });
}

function check_poll(){
  if ($("#auto_update").prop("checked")) {
    poll();
  } else {
    localStorage.carpool_ts = new Date().getTime() / 1000 >> 0;
  }
}

// poll() function will ask for new data since last time it ran every timedelay seconds
// It will timeout itself after 1 hour without any new data
function poll() {
  var timeout = 3600; // 1 hour
  var timedelay = 5000;
  var now = new Date().getTime() / 1000 >> 0;
  var check = ($("#auto_update").prop("checked"));
  $.getJSON('/carpools?since='+localStorage.carpool_mark, null, function(data) {
    if (data.length > 0) {
      $.each(data, function(i,car){
        update_carpool_info(car);
      });
      localStorage.carpool_ts = now;
    }
    localStorage.carpool_mark = now;
    if (localStorage.carpool_ts == null || localStorage.carpool_ts == "null"){
      localStorage.carpool_ts = now;
    }
    ts = parseInt(localStorage.carpool_ts);
    if (now-ts < timeout && check) {
      setTimeout(poll, timedelay)
    //} else {
    };
  });
}

function car_leaving() {
  update_car_status($(this).data('id'), "done");
}

function car_waiting() {
  var id = $(this).data('id');
  $.getJSON("/carpools/"+id, function(data){
    var car = data.carpool;
    var pax_list = "";
    $.each(car.passengers, function(idx, passenger){
      pax_list += $("#pax-list-template").html()
        .replace(/__pax.id_/g, passenger.id)
        .replace(/__pax.name_/g, passenger.name)
        .replace(/__pax.class_/g, passenger.class);
    });
    var html_str = $("#carpool-passenger-template").html()
      .replace(/__passengers.list_/i, pax_list);
    $("#show-modal").html(html_str);
    $("#show-modal").openModal();
  });
}

function car_to_wait_list() {
  update_car_status($(this).data('id'), $(this).prop("checked") ? "waiting" : "ready");
}

function update_car_status(id, status) {
  url = "/carpools/" + id;
  var dataToSend = new Object();
  dataToSend = { carpool: { status: status }};
  var jsonData = JSON.stringify(dataToSend);
  $.ajax({
    type: 'PATCH',
    contentType: "application/json; charset=utf-8",
    url: url,
    data: jsonData,
    dataType: 'json',
    success: function(data) {
      update_carpool_info(data.carpool);
    },
    error: function() {
      Materialize.toast("Sorry...I'm confused", 5000, 'red');
    }
  });
}

function update_carpool_info(car) {
  var target = $("#car-"+car.id);
  if (target.length == 0) {
    var html_str = $("#carpool-template").html()
      .replace(/__carpool.id_/g, car.id)
      .replace(/__carpool.transport_name_/g, car.transport_name)
      .replace(/__carpool.status_/g, car.status);
    $(".carpool").append(html_str);
  } else {
    target.removeClass('ready loading waiting');
    target.addClass(car.status);
  }
  if (car.status == "done") {
    target.fadeOut('slow', function(){ target.remove(); });
  }
}

function carpool_document_ready(){
  $("#carpool_scanner").codeScanner({
    minEntryChars: 10,
    onScan: function($element, barcode){
      carpool_scanner($element, barcode);
    }
  });
  $("#auto_update").on("change", check_poll);
  $("[name^='car-done']").on("change", car_leaving);
  $("[name^='car-wait']").on("change", car_to_wait_list);
  localStorage.carpool_mark = (new Date().getTime()/1000) >> 0;
  poll();
}

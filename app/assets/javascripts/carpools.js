var CarpoolApp = (function(){
  
  var Transport = {
    id:'',
    transportName: '',
    _status: 'ready',
    passengers: [],
    carpoolId:'',
    //expectedPassengers: [],
    
    init: function(car) {
      var transport = Object.create(Transport);
      transport.category = car.category;
      transport._status = car.status;
      transport.id = car.transport_id;
      transport.transportName = car.transport_name;
      transport.carpoolId = car.id;
      return transport;
    },

    template: function() { return $("#carpool-template") },
    
    htmlStr: function() { return this.template().html()
              .replace(/__carpool.id_/g, this.carpoolId)
              .replace(/__transport.name_/g, this.transportName)
              .replace(/__transport.id_/g, this.id)
              .replace(/__transport.status_/g, this.status);
    },
    
    node: function() { return $("#car-" + this.carpoolId) },
    
    doneCheckBox: function() { return $("#car-done-" + this.carpoolId) },
    waitCheckBox: function() { return $("#car-wait-" + this.carpoolId) },
    
    render: function() {
      if ($(".carpool").has(this.node()).length == 0) {
        var container;
        if (this.status == 'done') {
          container = $("#exit-carpool");
        } else if (this.status == 'waiting') {
          container = $("#waiting-cars");
        } else if (this.category == 'private') {
          container = $("#private-cars");
        } else if (this.category == 'shuttle') {
          container = $("#shuttle-cars");
        } else {
          container = $("#data-error");
        }
        console.log("Rendering transport "+this.transportName+" with status "+this.status);
        // console.log("Rendering transport "+this.transportName+" with status "+this.status+" in "+container.selector);
        container.append(this.htmlStr());
        this.doneCheckBox().prop("checked", this.status == 'done');
        this.waitCheckBox().prop("checked", this.status == 'waiting');        
      } else {
        // console.log("Node present. Nothing to render "+this.transportName);
      }
    },

    set status(s) {
      var prevStatus = this._status;
      if (this._status != s) {
        // console.log("Changing status from "+this.status+" to "+s); 
        this._status = s;
        this.node().removeClass('ready leaving loading waiting done')
          .addClass(this._status);
        // console.log("Now, "+this._status+" check: "+$("#car-done-"+this.id).prop("checked"));
        var transport = this;
        this.node().fadeOut('slow', function(){ 
          this.remove(); 
          // console.log("Element removed! status: "+transport.status);
          transport.render();
        });
        if (prevStatus != s) {
          this.uploadStatus();
        }
      }      
    },

    get status() {
      return this._status;
    },

    getPax: function(paxId) {
      return this.expectedPassengers.find(function(pax) {
        return pax.id == paxId;
      })
    },

    getPassengers: function() {
      // console.log('Getting passengers list for ', this.transportName);
      $.getJSON('/transports/'+this.id, null, function(data) {
        var list = [];
        var transport = this;
        var passengerList = data.transport.members;
        if (passengerList.length > 0) {
          $.each(passengerList, function(i,passenger){
            // console.log('Got pax '+passenger.name);
            var pax = Passenger.init(transport, passenger);
            pax.render();
          });   
        }
      });
    },

    uploadStatus: function () {
      url = "/carpools/" + this.carpoolId;
      var dataToSend = new Object();
      dataToSend = { carpool: {
                      status: this.status
                   } };
      var jsonData = JSON.stringify(dataToSend);
      $.ajax({
        type: 'PATCH',
        contentType: "application/json; charset=utf-8",
        url: url,
        data: jsonData,
        dataType: 'json',
        success: function(data) {
          // console.log("Car status uploaded: "+status);          
          console.log("Updated at: "+data.timestamp);
        },
        error: function() {
          Materialize.toast("Sorry...I'm confused", 5000, 'red');
        }
      });
    },

    updateExpectedPassengers: function(passengers){      
      var transport = this;
      if (passengers) {
        $.each(passengers, function(idx, pax){
          var passenger = transport.getPax(pax.id);
          if (passenger) {
            // console.log("Found passenger " + passenger.name);
            passenger.status = pax.status;    
            if (transport.expectedPassengers.filter(function(p){return p.status}).length == 0) {
              this.status = 'done';
            }; 
          } else {
            // console.log("Adding passenger " + pax.name);
            var listEntry = ExpectedPax.init(transport, pax);
            transport.expectedPassengers.push(listEntry);
            listEntry.render();
          }
        });
      } 
    },

    updateExpectedPassengerStatus: function(id, status){
      var pax = this.getPax(id);
      // console.log("Updating pax "+pax.name+', status: '+status);
      if (pax) pax.status = status;
      // if (!status) this.removeExpectedPax(pax.id);
      if (this.expectedPassengers.filter(function(p){return p.status}).length == 0) {
        this.status = 'done';
      };
    }
  };

  var Carpool = {
    init: function () {
      Carpool.carpoolList = [];
      Carpool.autoPolling = true;
      Carpool.bindEvents();
      Carpool.debug = Object.new;
      var time = new Date();
      // if AM, start at midnight, otherwise start at noon:
      localStorage.carpool_start = time.setHours(time.getHours() < 12 ? 0 : 12, 0, 0, 0);
      localStorage.carpool_mark = localStorage.carpool_start;
      Carpool.poll();
    },

    bindEvents: function () {
      $("#carpool_scanner").codeScanner({
        minEntryChars: 9, 
        maxEntryTime: 500,
        onScan: function($element, barcode){
          // console.log("Scanned "+barcode);
          Carpool.handleScan($element, barcode);
        }
      });
      $("#auto_update").on("change", Carpool.togglePolling.bind(this));
      // $(".carpool").on("change", "[name^='car-done']", Carpool.handleCarMoves.bind(this));
      // $(".carpool").on("change", "[name^='car-wait']", Carpool.handleCarWaiting.bind(this));
      $(".carpool").on("change", "[name^='pax-status']", Carpool.handlePaxMoves.bind(this));
      $(".carpool").on("click", ".modal-trigger", Carpool.handleShowPassengers.bind(this));
      $("#submit-carpool").on("click", Carpool.handleCarpoolEntry.bind(this));
      // $(".carpool").on("click", ".submit-carpool", Carpool.handleCarpoolEntry.bind(this));
      $("#car-entry").on('keypress' , '#transport_name', function(e) {
        if(e && e.keyCode == 13) {
          Carpool.handleCarpoolEntry();
        }
      });
      $(".carpool").on("click", ".done-wrapper", Carpool.handleDone.bind(this));
      $(".carpool").on("click", ".wait-wrapper", Carpool.handleWait.bind(this));
    },

    handleScan: function (el, barcode) {
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
          Materialize.toast('Welcome! ' + car.id + '-' + car.transport_name, 5000, 'green');        
          Carpool.create(car);
          localStorage.carpool_mark = data.timestamp;
        },
        error: function() {
          Materialize.toast('Error: invalid card', 5000, 'red');
        }
      });
    },

    getTransport: function(transportId) {
      return Carpool.carpoolList.find(function(transport) {
        return transport.id == transportId;
      })
    },

    create: function(car) {
      var transport = Transport.init(car);
      Carpool.carpoolList.push(transport);
      transport.render();
      // if (car.late_passengers) {
      //   $.each(car.late_passengers, function(idx, passenger) {
      //     var listEntry = ExpectedPax.init(transport, passenger);
      //     transport.expectedPassengers.push(listEntry);
      //     listEntry.render(); 
      //   });
      // }
    },

    update: function(car) {      
      var transport = Carpool.getTransport(car.transport_id);
      // transport.updateExpectedPassengers(car.late_passengers);
      transport.status = car.status;
    },

    createOrUpdate: function(car) {
      if (Carpool.getTransport(car.transport_id)) {
        Carpool.update(car);
      } else {
        Carpool.create(car);
      }
    },

    // handleCarMoves: function(e) {
    //   var $el = $(e.target);       
    //   var transportId = $el.data('id');
    //   var transport = Carpool.getTransport(transportId);
    //   transport.status = $el.prop("checked") ? "done" : "ready";
    // },
    
    handleDone: function(e) {
      var $el = $(e.target);
      if ($el.prop('tagName') == 'LABEL') return;  
      var transportId = $el.closest(".done-wrapper").data('id');
      var transport = Carpool.getTransport(transportId);
      if (transport) transport.status = transport.status != 'done' ? "done" : "ready";
    },

    // handleCarWaiting: function(e) {
    //   var $el = $(e.target);       
    //   var transportId = $el.data('id');
    //   var transport = Carpool.getTransport(transportId);
    //   transport.status = $el.prop("checked") ? "waiting" : "ready";
    // },

    handleWait: function(e) {
      var $el = $(e.target);
      if ($el.prop('tagName') == 'LABEL') return;  
      var transportId = $el.closest(".wait-wrapper").data('id');
      var transport = Carpool.getTransport(transportId);
      // console.log("Click on "+e.target.nodeName+": "+$el.attr('class')+" with transport id: "+transportId);
      // console.log("Handle wait for transport "+transportId+" ("+transport.transportName+")");
      if (transport) transport.status = transport.status != 'waiting' ? "waiting" : "ready";
    },

    handlePaxMoves: function(e) {
      var el = e.target;
      var $el = $(el);       
      var paxId = $el.data('id');
      var paxStatus = $el.prop("checked");
      var transportId = $el.data('transport');      
      var transport = Carpool.getTransport(transportId);
      transport.updateExpectedPassengerStatus(paxId, paxStatus);
    },

    handleShowPassengers: function(e) {
      var el = e.target;
      var $el = $(el);
      var transportId = $el.data('id');
      var transport = Carpool.getTransport(transportId);
      $("#passenger-list").html('');
      transport.getPassengers();
      $('#show-modal').openModal();
    },

    handleCarpoolEntry: function() {
      url = "/carpools/";
      var dataToSend = new Object();
      dataToSend = { carpool: {
                      transport_name: $("#transport_name").val().toUpperCase()
                   } };
      var jsonData = JSON.stringify(dataToSend);
      $.ajax({
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        url: url,
        data: jsonData,
        dataType: 'json',
        success: function(data) {
          var car = data.carpool;
          $("#transport_name").val("");
          Carpool.createOrUpdate(car);
        },
        error: function(data) {
          var messages = JSON.parse(data.responseText).messages;
          Materialize.toast(messages ? messages[0] : "Invalid shuttle/family number "+$("#transport_name").val(), 5000, 'red');
          $("#transport_name").val("");
        }
     });
    },

    poll: function() {      
      var timeout = 3600000; // 1 hour
      var timedelay = 5000;
      var now = new Date().getTime();
      $.getJSON('/carpools/poll?since='+localStorage.carpool_mark, null, function(data) {        
        var carpool = data.carpool;
        if (carpool.length > 0) {
          $.each(carpool, function(i,car){
            Carpool.createOrUpdate(car);
          });
          localStorage.carpool_ts = now;  // Mark last polling having  data
        }
        localStorage.carpool_mark = data.timestamp;
        if (localStorage.carpool_ts == null || localStorage.carpool_ts == "null"){
          localStorage.carpool_ts = now;
        }
        var ts = parseInt(localStorage.carpool_ts);
        if (now - ts < timeout && Carpool.autoPolling) {
          setTimeout(Carpool.poll, timedelay)
        };
      });
    },

    togglePolling: function() {
      if (! Carpool.autoPolling) {
        Carpool.poll();
        Carpool.autoPolling = true;
        Materialize.toast("Auto-update ON", 5000, 'green');
      } else {
        localStorage.carpool_ts = new Date().getTime();
        Carpool.autoPolling = false;
        Materialize.toast("Auto-update OFF", 5000, 'green');
      }
    }
    
    // getShuttleCars: function() {
    //   Carpool.carpoolList.filter(function(carpool){
    //     return carpool.category == "shuttle";
    //   })
    // },

    // getPrivateCars: function() {
    //   Carpool.carpoolList.filter(function(carpool){
    //     return carpool.category == "private";
    //   })
    // },

    // getDoneCars: function() {
    //   Carpool.carpoolList.filter(function(carpool){
    //     return carpool.status == "done";
    //   })
    // },

    // getWaitingList: function() {

    // },

  };


  var Passenger = {
    id:'',
    name: '',
    grade: '',
    transportName: '',
    transportId: '',
    _active: false,

    init: function(transport, passenger) {      
      var pax = Object.create(Passenger);
      pax.id = passenger.id;    
      pax._active = passenger.status;
      pax.name = passenger.name;
      pax.grade = passenger.grade;
      pax.transportId = transport.id;
      pax.transportName = transport.transportName; 
      pax.status = passenger.status;
      return pax;
    },
    
    template: function() { return $("#passenger-template") },
    
    htmlStr: function() { return this.template().html()
              .replace(/__transport.name_/g, this.transportName)
              .replace(/__transport.id_/g, this.transportId)
              .replace(/__pax.id_/g, this.id)
              .replace(/__pax.name_/g, this.name)
              .replace(/__pax.grade_/g, this.grade);
    },  
    
    node: function() { return $("#passenger-" + this.id) },
    
    render: function() {          
      var container = $("#passenger-list");
      container.append(this.htmlStr());        
    }
  };

  var ExpectedPax = {
    id:'',
    name: '',
    grade: '',
    transportName: '',
    transportId: '',
    _active: false,

    init: function(transport, passenger) {      
      var expectedPax = Object.create(ExpectedPax);
      expectedPax.id = passenger.id;    
      expectedPax._active = passenger.status;
      expectedPax.name = passenger.name;
      expectedPax.grade = passenger.grade;
      expectedPax.transportId = transport.id;
      expectedPax.transportName = transport.transportName; 
      expectedPax.status = passenger.status;
      return expectedPax;
    },
    
    template: function() { return $("#expected-pax-template") },
    
    htmlStr: function() { return this.template().html()
              .replace(/__transport.name_/g, this.transportName)
              .replace(/__transport.id_/g, this.transportId)
              .replace(/__pax.id_/g, this.id)
              .replace(/__pax.name_/g, this.name)
              .replace(/__pax.grade_/g, this.grade);
    },  
    
    node: function() { return $("#pax-" + this.id) },
    
    statusCheckBox: function() { return $("#pax-status-" + this.id) },
    
    render: function() {
      // console.log("Rendered pax " + this.name);
      if (this.status) {
        var container = $("#expected-pax-list");
        container.append(this.htmlStr());
        this.statusCheckBox().prop("checked", this.status);
      }
    },
    
    set status(s) { 
      var prevStatus = this._active;
      if (this._active != s) {
        // console.log('Setting pax status for '+this.name+" to "+s);
        this._active = s;
        if (s == false) {          
          this.node().fadeOut('slow', function(){ 
            this.remove();        
          });      
        }
        if (prevStatus != s) {
          this.uploadStatus();
        }
      }      
    },
    
    get status() {
      return this._active;
    },

    uploadStatus: function () {
      // console.log('Uploading pax'+this.name+ ' status: '+this.status);
      url = "/pax/" + this.id;
      var dataToSend = new Object();
      dataToSend = { late_passenger: { active: this.status, transport_id: this.transportId } };
      var jsonData = JSON.stringify(dataToSend);
      $.ajax({
        type: 'PATCH',
        contentType: "application/json; charset=utf-8",
        url: url,
        data: jsonData,
        dataType: 'json',
        success: function(data) {
          // console.log("Pax status uploaded.");     
        },
        error: function() {
          Materialize.toast("Sorry...I'm confused", 5000, 'red');
        }
      });
    },

  };

  return Carpool;
})();

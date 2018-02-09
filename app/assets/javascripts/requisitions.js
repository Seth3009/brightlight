$(document).on("ready page:load page:change", function() {
    if ( $("body.requisitions.edit, body.requisitions.new, body.requisitions.approve").length == 0 ) {
        return;
    } else {
        $( function() {
            var dept = $("#requisition_department_id").prop("value");
        //     $( ".budget_item_autocomplete" ).autocomplete({
        //         source: "/budget_items?format=json&dept="+dept,
        //         max: 30,
        //         minLength: 2,
        //         select: function( event, ui ) {
        //         select_item(ui.item);
        //         return false;                 // Returning false is required so that the selection is displayed in the input field
        //                                         // See: http://hashmode.com/jquery-autocomplete-does-not-update-the-input-value/22
        //         }
        //     })
        //     .autocomplete( "instance" )._renderItem = function( ul, item ) {
        //         return $( "<li>" )
        //         .append( "<div>" + item.description + " Month: " + item.month + "/" + item.year +"</div>" )
        //         .appendTo( ul );
        //     };
            

            var enabled_state = function() {
                return $("#requisition_is_supv_approved").prop('checked') && 
                            !$("#requisition_is_budgeted").prop('checked') &&
                            $("#requisition_budget_approver_id").val() !== "";
            }

            var approval_state = function() {
                return !$("#requisition_is_supv_approved").prop('checked') && 
                            $("#requisition_supervisor_id").val() !== "";
            }

            $("#requisition_is_budgeted").on("change", function() {
                if($("#requisition_is_budgeted").prop('checked')) {
                    $("button[name='approve']").removeAttr('disabled');
                    $(".budget-approval").hide(400);
                } else {
                    $("button[name='approve']").prop('disabled', "disabled");
                    $(".budget-approval").show(400);
                    $("#requisition_budget_notes").val(null);
                    $("#requisition_budget_id").val(null);
                    $("#requisition_budget_item_id").val(null);
                }
                if( enabled_state() ) {
                    $("button#send_budget").removeAttr('disabled');
                } else {
                    $("button#send_budget").prop('disabled', "disabled");
                }
            }.bind(this));

            $("#requisition_is_supv_approved").on("change", function() {
                if( approval_state() ) {
                    $("button#send_supv").removeAttr('disabled');
                } else {
                    $("button#send_supv").prop('disabled', "disabled");
                }
            }.bind(this));

            $("#requisition_budget_approver_id").on("change", function() {
                if( enabled_state() ) {
                    $("button#send_budget").removeAttr('disabled');
                } else {
                    $("button#send_budget").prop('disabled', "disabled");
                }
            }.bind(this));

            $("#requisition_budget_item_id").on("change", function() {
                $("#requisition_is_budgeted").prop("checked", true);
                $("#requisition_is_budgeted").change(); 
            }.bind(this));

            function select_item(item) {
                var desc = item.description+" "+item.month+"/"+item.year;
                $("#requisition_budget_notes").val(desc);
                $("#requisition_budget_id").val(item.budget_id);
                $("#requisition_budget_item_id").val(item.id);
                $("#requisition_is_budgeted").prop("checked", true);
                $("#requisition_is_budgeted").change();       // Needed to hide/show the approval elements
            };
        } );
    }
});
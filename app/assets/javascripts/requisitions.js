$(document).on("ready page:load page:change", function() {        
    var dept = $("#requisition_department_id").prop("value");
    var can_send_for_budget_approval = function() {
        return $("#requisition_is_supv_approved").val() == "true" && 
                    $("#requisition_is_budget_approved").val() !== "true" && 
                    $("[name='requisition[is_budgeted]']:checked").val() == "true" && 
                    $("#requisition_supervisor_id").val() !== "" &&
                    $("#requisition_budget_approver_id").val() !== "";
    }
    var toggle_budget = function() {
        if($("[name='requisition[is_budgeted]']:checked").val() == "true") {
            $("button[name='approve']").removeAttr('disabled');
            $(".budget-approval").hide(400);
        } else {
            $("button[name='approve']").prop('disabled', "disabled");
            $(".budget-approval").show(400);
            $("#requisition_budget_notes").val(null);
        }
        if( can_send_for_budget_approval() ) {
            $("button#send_budget").removeAttr('disabled');
        } else {
            $("button#send_budget").prop('disabled', "disabled");
        }
    };

    $("[name='requisition[is_budgeted]']").on("change", toggle_budget);

    $("#requisition_is_supv_approved").on("change", function() {
        if( can_send_for_budget_approval() ) {
            $("button#send_budget").removeAttr('disabled');
        } else {
            $("button#send_budget").prop('disabled', "disabled");
        }
    });

    $("#requisition_is_budget_approved").on("change", function() {
        if( can_send_for_budget_approval() ) {
            $("button#send_budget").removeAttr('disabled');
        } else {
            $("button#send_budget").prop('disabled', "disabled");
        }
    });

    $("#requisition_budget_approver_id").on("change", function() {
        if( can_send_for_budget_approval() ) {
            $("button#send_budget").removeAttr('disabled');
        } else {
            $("button#send_budget").prop('disabled', "disabled");
        }
    });
});
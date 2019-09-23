// On Requisition request and approval pages
$(document).on('page:load ready', function() {
    $("input#requisition_date_required").on("change", function(event) {
        var date = $("input#requisition_date_required").val();
        $("a.add_fields").data("associationInsertionTemplate", 
        $("a.add_fields").data("associationInsertionTemplate").replace(/(needed_by_date").+(\/>)/, '$1 value="' + date + '" $2'));
    });

    $(document).on("blur", "#requisition .nested-fields", function() {
        calc_row_total($(this));
        calc_total();
    });
    $(document).on("change", "#requisition .nested-fields input", function() {
        calc_row_total($(this).parents(".nested-fields"));
        calc_total();
    });

    var calc_row_total = function(row) {
        var qty = Number(row.find("input[name$='[qty_reqd]']").val());
        var unit_price = Number(row.find("input[name$='[est_price]']").val());
        var line_total_field = row.find("input[name$='line_total']");
        var line_total = qty*unit_price;
        line_total_field.val(line_total);
        return line_total;
    };
    var calc_total = function() {
        var total = $.map($("#requisition").find("input[name$='line_total']"), function(item) { 
                return Number($(item).val()) })
            .reduce(function(tot, val){return tot+val}, 0);
        $("#req-items #total").html(new Intl.NumberFormat('en-US').format(total));
    };
});




// $(document).on("ready page:load page:change", function() {        
    // var dept = $("#requisition_department_id").prop("value");
    // var can_send_for_budget_approval = function() {
    //     return $("#requisition_is_supv_approved").val() == "true" && 
    //                 $("#requisition_is_budget_approved").val() !== "true" && 
    //                 $("[name='requisition[is_budgeted]']:checked").val() == "true" && 
    //                 $("#requisition_supervisor_id").val() !== "" &&
    //                 $("#requisition_budget_approver_id").val() !== "";
    // }
    // var toggle_budget = function() {
    //     if($("[name='requisition[is_budgeted]']:checked").val() == "true") {
    //         $("button[name='approve']").removeAttr('disabled');
    //         $(".budget-approval").hide(400);
    //     } else {
    //         $("button[name='approve']").prop('disabled', "disabled");
    //         $(".budget-approval").show(400);
    //         $("#requisition_budget_notes").val(null);
    //     }
    //     if( can_send_for_budget_approval() ) {
    //         $("button#send_budget").removeAttr('disabled');
    //     } else {
    //         $("button#send_budget").prop('disabled', "disabled");
    //     }
    // };

    // $("[name='requisition[is_budgeted]']").on("change", toggle_budget);

    // $("#requisition_is_supv_approved").on("change", function() {
    //     if( can_send_for_budget_approval() ) {
    //         $("button#send_budget").removeAttr('disabled');
    //     } else {
    //         $("button#send_budget").prop('disabled', "disabled");
    //     }
    // });

    // $("#requisition_is_budget_approved").on("change", function() {
    //     if( can_send_for_budget_approval() ) {
    //         $("button#send_budget").removeAttr('disabled');
    //     } else {
    //         $("button#send_budget").prop('disabled', "disabled");
    //     }
    // });

    // $("#requisition_budget_approver_id").on("change", function() {
    //     if( can_send_for_budget_approval() ) {
    //         $("button#send_budget").removeAttr('disabled');
    //     } else {
    //         $("button#send_budget").prop('disabled', "disabled");
    //     }
    // });
// });


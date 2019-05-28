$(document).on("ready page:load", function(){
	if ($("body.settings").length == 0) return;

	var init_checkboxes = function(group) {
		var group_id = "#"+group;
		var button_id = "."+group+"-button";
		var toggle_button = function() {
			var checked = $(group_id + ' input.checkbox:checked').length > 0;
			if (checked) {
				$(button_id).removeClass("disabled");
			} else {
				$(button_id).addClass("disabled");
			}
			$(button_id).prop("disabled", !checked);
		};

		$(group_id+" .checkbox").on("change", function() {
			toggle_button();
			$(group_id+" .allcheckboxes").prop("checked", $(group_id+" .allcheckboxes").data("total") == $('input.checkbox:checked').length);
		});

		$(group_id+" .allcheckboxes").on("change", function(e) {
			$(group_id+" input.checkbox"+"."+group).prop("checked", $(e.target).prop("checked"));
			toggle_button();
		});
	};

	init_checkboxes("initialize_standard_books");
	init_checkboxes("initialize_courses");
	init_checkboxes("finalize_student_books");
	init_checkboxes("prepare_book_receipts");
	init_checkboxes("finalize_condition_book_receipts");
	init_checkboxes("prepare_student_books");
	init_checkboxes("calculate_book_fines");

});
$('.dropdown-button').dropdown({
	inDuration: 300,
	outDuration: 225,
	constrain_width: false, // Does not change width of dropdown to that of the activator
	hover: false, // Activate on hover
	gutter: 0, // Spacing from edge
	belowOrigin: true, // Displays dropdown below the button
	alignment: 'left' // Displays dropdown with edge aligned to the left of button
});
$('.collapsible').collapsible({
	accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
});
$(".sidebar-collapse").sideNav();

// Materialize sideNav  

// $(".sidebar-collapse").sideNav({
// 	menuWidth:300px;
// 	edge: 'left';
// 	closeOnClick: true;
// });


// Default
// Bootswatch
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
// require turbolinks <= turbolinks was removed because the page loading
//= require default/loader
//= require default/bootswatch
//= require best_in_place

// AngularJS
//= require angular
//= require angular-animate
//= require angular-resource
//= require main
//= require_tree ./angular
//= require_tree .

// Custom js files
//= require header
//= require users

$(document).ready(function() {
	/* Activating Best In Place */
	$(".best_in_place").best_in_place();

	/* DatePicker Date Format */
	$.datepicker.setDefaults({ dateFormat: 'dd/mm/yy' });
});

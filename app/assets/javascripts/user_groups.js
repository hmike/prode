
$(document).ready(function() {
	//@todo: hmike: move to user groups js
	$('table.table.tbl-groups tbody tr.row-group').click(function() {
		$(this).find('td a').click();
	})
	// $('input[type="radio"]').click(function() {
	// 	$(this).parent('button').click();
	// 	console.log("active button");
	// })
});

$(document).mouseup(function (e) {
	// if clicks outside the subnavbar and the right-navbar list (for toggle menu action when click twice)
	var subnavbar = $(".navbar.navbar-fixed-top.subnavbar");
	if (!subnavbar.is(e.target) // if the target of the click isn't the container...
		&& subnavbar.has(e.target).length === 0) // ... nor a descendant of the container
	{
		var rightnavbar = $("ul.nav.navbar-nav.navbar-right li");
		if (!rightnavbar.is(e.target) // if the target of the click isn't the container...
			&& rightnavbar.has(e.target).length === 0) // ... nor a descendant of the container
		{
			hideAllSubnavbarMenus();
		}
	}
});

function hideAllSubnavbarMenus(){
	$(".navbar.navbar-fixed-top.subnavbar > .container > div[class^='subnavbar-']").hide();
	return false;
}

function toggleSubnavbarMenu(submenu){
	if (!$('.' + submenu).is(':visible')){
		hideAllSubnavbarMenus();
	}
	$('.' + submenu).toggle();
	return false;
}

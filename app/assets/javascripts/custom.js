//document.write("Are you");
function toggle_debug() {
	//document.write("Hello my hero");
	var d = document.getElementsByClassName("debug_information");
	for (var i = 0; i < d.length; i++) {
	  if (d[i].style.display == "none")
	  	d[i].style.display = "block"
	  else
	  	d[i].style.display = "none"
	}
}

function toggle_debug() {
	var d = document.getElementsByClassName("debug_information");
	//or d[i].style.display == "none"? d[i].style.display = "block" : d[i].style.display == "none"; 
	for (var i = 0; i < d.length; i++) {
	  if (d[i].style.display == "none")
	  	d[i].style.display = "block"
	  else
	  	d[i].style.display = "none"
	}
}
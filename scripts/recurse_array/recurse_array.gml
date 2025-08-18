function recurse_array(array, scr, args){
	var contentLength = array_length(array);
	
	for(var i = 0; i < contentLength; i++){
		var element = array[i];
		
		if (is_array(element)) calculate_content(element, scr, args);
		else scr(element, args);
	}	
}

function recurse_array_reverse(array, scr, args){
	var contentLength = array_length(array);
	
	for(var i = 0; i < contentLength; i++){
		var element = array[i];
		
		if (is_array(element)) recurse_array_reverse(element, scr, args);
		else scr(element);
	}	
}
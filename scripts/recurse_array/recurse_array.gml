/*
	This functions recurses trough an array
	it checks if it is an array 
	if it isnt it executes the script and provides the element
	along with other arguments (if more than one it'd be best to use an array)
	
	incase an array contains both arrays and other values like structs
*/

function recurse_array(array, scr, args, index = 0){
	var contentLength = array_length(array);
	
	for(var i = 0; i < contentLength; i++){
		var element = array[i];
		
		if (is_array(element)) index = recurse_array(element, scr, args, index + i);
		else scr(element, args, index + i);
	}
	
	return index + i;
}

function recurse_array_reverse(array, scr, args, index = 0){
	var contentLength = array_length(array);
	
	for(var i = contentLength - 1; i >= 0; i--){
		var element = array[i];
		
		if (is_array(element)) index = recurse_array_reverse(element, scr, args, index + i);
		else scr(element, args, index + i);
	}	
	
	return index + i;
}
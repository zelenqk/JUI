function array_recurse(array, check, args = undefined){
	if (!is_array(array)){
		check(array, args);
		return;
	}
	
	for(var i = 0; i < array_length(array); i++){
		var element = array[i];
		
		if (is_array(element)) array_recurse(element, check, args);
		else check(element, args);
	}
}

function draw_content(){
	for(var i = 0; i < array_length(segments); i++){
		var segment = segments[i];
		segment.draw();
	}
}

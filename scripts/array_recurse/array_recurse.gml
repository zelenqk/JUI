function array_recurse(array, check){
	for(var i = 0; i < array_length(array); i++){
		var element = array[i];
		
		if (is_array(element)) array_recurse(element, check);
		else check(element);
	}
}

function draw_content(content){
	if (is_array(content)){
		for(var i = 0; i < array_length(content); i++){
			var element = content[i];
			draw_content(element);
		}
		return;
	}
	
	content.draw();
}
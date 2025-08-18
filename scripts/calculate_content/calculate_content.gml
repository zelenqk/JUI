function calculate_content(content, efficient, index = 0){
	var contentLength = array_length(content)
	
	for(var i = 0; i < contentLength; i++){
		var element = content[i];
		
		if (is_array(element)) calculate_content(element, efficient, index + i);
		else element.calculate();
	}
}
function calculate_content(content, index = 0, type){
	var contentLength = array_length(content)
	
	for(var i = 0; i < contentLength; i++){
		var element = content[i];
		
		if (is_array(element)) calculate_content(element, index + i);
		else if (element.position == type) element.calculate();
	}
}
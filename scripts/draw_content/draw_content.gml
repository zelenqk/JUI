function draw_content(content){
	if (!is_array(content)){
		content.draw();
		return;
	}
	
	var contentLength = array_length(content);
	for(var i = 0; i < contentLength; i++){
		draw_content(content[i]);
	}
}
function draw_content(content){
	var contentLength = array_length(content);
	var i = 0;
	
	repeat (contentLength){
		content[i++].draw();
	}
}
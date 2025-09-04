function draw_content(content, tx = 0, ty = 0){
	var contentLength = array_length(content);
	var i = 0;
	
	repeat (contentLength) content[i++].draw(tx, ty);
}
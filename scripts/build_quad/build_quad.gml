#macro EMPTY_UV {x: 0, y: 0, width: 1, height: 1}


function build_quad(vbuff, anchorx, anchory, w, h, color, alpha, uv = EMPTY_UV){
	var startx = -(w * anchorx);
	var starty = -(h * anchory);
	
	//left tri
	//top left
	vertex_position(vbuff, startx, starty);
	vertex_texcoord(vbuff, uv.x, uv.y);
	vertex_color(vbuff, color, alpha);
	
	//top right
	vertex_position(vbuff, startx + w, starty);
	vertex_texcoord(vbuff, uv.x + uv.width, uv.y);
	vertex_color(vbuff, color, alpha);
	
	//bottom left
	vertex_position(vbuff, startx, starty + h);
	vertex_texcoord(vbuff, uv.x, uv.y + uv.height);
	vertex_color(vbuff, color, alpha);
	
	//right tri
	//top right
	vertex_position(vbuff, startx + w, starty);
	vertex_texcoord(vbuff, uv.x + uv.width, uv.y);
	vertex_color(vbuff, color, alpha);
	
	//bottom left
	vertex_position(vbuff, startx, starty + h);
	vertex_texcoord(vbuff, uv.x, uv.y + uv.height);
	vertex_color(vbuff, color, alpha);
	
	//bottom right
	vertex_position(vbuff, startx + w, starty + h);
	vertex_texcoord(vbuff, uv.x + uv.width, uv.y + uv.height);
	vertex_color(vbuff, color, alpha);
	
	//finish
	vertex_end(vbuff);
	vertex_freeze(vbuff);
}
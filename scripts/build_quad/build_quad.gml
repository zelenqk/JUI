function build_quad(uvs){
	vertex_begin(cache.vbuff, JUI_FORMAT);
	
	// Top-left
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[0], uvs[1]); // left, top
	vertex_position(cache.vbuff, -efficient.width / 2, -efficient.height / 2);
	
	// Top-right
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[2], uvs[1]); // right, top
	vertex_position(cache.vbuff, efficient.width / 2, -efficient.height / 2);
	
	// Bottom-right
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[2], uvs[3]); // right, bottom
	vertex_position(cache.vbuff, efficient.width / 2, efficient.height / 2);
	
	// Bottom-left
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[0], uvs[3]); // left, bottom
	vertex_position(cache.vbuff, -efficient.width / 2, efficient.height / 2);
	
	vertex_end(cache.vbuff);
}
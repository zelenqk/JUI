function build_quad(uvs){
	// Top-left
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[0], uvs[1]); // left, top
	vertex_position(cache.vbuff, -target.anchorx, -target.anchory);
	
	// Top-right
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[2], uvs[1]); // right, top
	vertex_position(cache.vbuff, efficient.width - target.anchorx, -target.anchory);
	
	// Bottom-right
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[2], uvs[3]); // right, bottom
	vertex_position(cache.vbuff, efficient.width - target.anchorx, efficient.height - target.anchory);
	
	// Bottom-right
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[2], uvs[3]); // right, bottom
	vertex_position(cache.vbuff, efficient.width - target.anchorx, efficient.height - target.anchory);

	// Bottom-left
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[0], uvs[3]); // left, bottom
	vertex_position(cache.vbuff, -target.anchorx, efficient.height - target.anchory);
	
	// Top-left
	vertex_color(cache.vbuff, background, 1);
	vertex_texcoord(cache.vbuff, uvs[0], uvs[1]); // left, top
	vertex_position(cache.vbuff, -target.anchorx, -target.anchory);
}
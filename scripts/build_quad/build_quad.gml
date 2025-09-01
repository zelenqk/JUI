function build_quad(uvs){
	vertex_begin(vertexBuffer, JUI_FORMAT);
	
	// Top-left
	vertex_color(vertexBuffer, background, opacity);
	vertex_texcoord(vertexBuffer, uvs[0], uvs[1]); // left, top
	vertex_position(vertexBuffer, -efficient.width / 2, -efficient.height / 2);
	
	// Top-right
	vertex_color(vertexBuffer, background, opacity);
	vertex_texcoord(vertexBuffer, uvs[2], uvs[1]); // right, top
	vertex_position(vertexBuffer, efficient.width / 2, -efficient.height / 2);
	
	// Bottom-right
	vertex_color(vertexBuffer, background, opacity);
	vertex_texcoord(vertexBuffer, uvs[2], uvs[3]); // right, bottom
	vertex_position(vertexBuffer, efficient.width / 2, efficient.height / 2);
	
	// Bottom-left
	vertex_color(vertexBuffer, background, opacity);
	vertex_texcoord(vertexBuffer, uvs[0], uvs[3]); // left, bottom
	vertex_position(vertexBuffer, -efficient.width / 2, efficient.height / 2);
	
	vertex_end(vertexBuffer);
}
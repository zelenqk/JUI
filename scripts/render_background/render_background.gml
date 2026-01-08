function render_background(){
	if (vbuff != auto) return;
	vbuff = vertex_create_buffer();
	
	vertex_begin(vbuff, JUI_FORMAT);
	switch (background.type){
	case asset_surface:
		var surface = background.value;
		texture = surface.texture;
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, c_white, efficient.opacity);
		break;
	case asset_sprite:
		var sprite = background.value;
		var uv = sprite_get_uvs(background.value, 0);
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, c_white, efficient.opacity, {
			x: uv[0],	
			y: uv[1],
			width: uv[2] - uv[0],
			height: uv[3] - uv[1],
		});
		
		texture = sprite_get_texture(sprite, 0);
		break;
	default:
		var color = c_white;
		if (is_ptr(background.value)) texture = background.value;
		else color = background.value;
		
		build_quad(vbuff, anchor.x, anchor.y, efficient.width, efficient.height, color, efficient.opacity);
		break;
	}	
}
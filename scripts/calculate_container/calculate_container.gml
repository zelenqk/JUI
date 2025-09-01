function calculate_container(parent = self.parent){
	if (parent == BASE_CONTAINER) position = fixed;
		
	target.x = parent.target.x + x;
	target.y = parent.target.y + y;
	
	//dimensions
	target.width = calculate_value(width, parent.target.width);
	target.height = calculate_value(height, parent.target.height);

	//padding
	target.padding.left = calculate_value(padding.left, parent.target.width);
	target.padding.right = calculate_value(padding.right, parent.target.width);
	target.padding.top = calculate_value(padding.top, parent.target.height);
	target.padding.bottom = calculate_value(padding.bottom, parent.target.height);
	
	//margin
	target.margin.left = calculate_value(margin.left, parent.target.width);
	target.margin.right = calculate_value(margin.right, parent.target.width);
	target.margin.top = calculate_value(margin.top, parent.target.height);
	target.margin.bottom = calculate_value(margin.bottom, parent.target.height);
	
	//
	efficient.width = target.width;
	efficient.height = target.height;
	
	generate_layout();
	
	//origin of the quad (this will be used for matrix stuff and will be offsted when a layout is generated)
	target.anchorx = get_anchor(self.anchorx, efficient.width);
	target.anchory = get_anchor(self.anchory, efficient.height);
	
	//matrix stuff wont be offseted in the layout and can be used of animations and whatnot
	if (matrix.scale == auto) matrix.scale = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	if (matrix.rotation == auto) matrix.rotation = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	target.x += efficient.width;
	target.y += efficient.height;
	
	matrix.scale[MAT.X] = target.x;
	matrix.scale[MAT.Y] = target.y;
	//style
	
	////radius
	target.radius.top.left = calculate_value(radius.top.left, efficient.height);
	target.radius.top.right = calculate_value(radius.top.right, efficient.height);
	target.radius.bottom.left = calculate_value(radius.bottom.left, efficient.height);
	target.radius.bottom.right = calculate_value(radius.bottom.right, efficient.height);
	
	////background
	target.background = (is_array(background) or background <= auto) ? get_rgb(c_white) : get_rgb(background);
	
	//create vertex buffer
	var uvs = [0, 0, 0, 0];
	if (sprite != auto){
		texture = sprite_get_texture(sprite, image);
		uvs = sprite_get_uvs(sprite, image);
	}
	
	build_quad(uvs);
}
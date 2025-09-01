function calculate_container(){
	if (parent == BASE_CONTAINER) position = fixed;
	
	target.x = parent.target.x + x;
	target.y = parent.target.y + y;
	
	//dimensions
	target.width = calculate_value(width, parent.target.width);
	target.height = calculate_value(height, parent.target.height);

	//target.padding.left = calculate_value(padding.left, parent.target.width);
	//target.padding.right = calculate_value(padding.right, parent.target.width);
	//target.padding.top = calculate_value(padding.top, parent.target.height);
	//target.padding.bottom = calculate_value(padding.bottom, parent.target.height);
	
	//target.margin.left = calculate_value(margin.left, parent.target.width);
	//target.margin.right = calculate_value(margin.right, parent.target.width);
	//target.margin.top = calculate_value(margin.top, parent.target.height);
	//target.margin.bottom = calculate_value(margin.bottom, parent.target.height);
	
	efficient.width = target.width;
	efficient.height = target.height;
	
	generate_layout();
	
	if (matrix.scale == auto) matrix.scale = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	if (matrix.rotation == auto) matrix.rotation = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	target.x += efficient.width / 2;
	target.y += efficient.height / 2;
	
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
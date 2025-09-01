function calculate_container(){
	if (parent == BASE_CONTAINER) position = fixed;
	
	target.x = parent.target.x + x;
	target.y = parent.target.y + y;
	
	//dimensions
	target.width = calculate_value(width, parent.target.width);
	target.height = calculate_value(height, parent.target.height);

	target.padding = {};
	//target.padding.left = calculate_value(padding.left, parent.target.width);
	//target.padding.right = calculate_value(padding.right, parent.target.width);
	//target.padding.top = calculate_value(padding.top, parent.target.height);
	//target.padding.bottom = calculate_value(padding.bottom, parent.target.height);
	
	target.margin = {};
	//target.margin.left = calculate_value(margin.left, parent.target.width);
	//target.margin.right = calculate_value(margin.right, parent.target.width);
	//target.margin.top = calculate_value(margin.top, parent.target.height);
	//target.margin.bottom = calculate_value(margin.bottom, parent.target.height);
	
	generate_layout();
	efficient.width = target.width;
	efficient.height = target.height;
	
	if (matrix.scale == auto) matrix.scale = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	if (matrix.rotation == auto) matrix.rotation = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	matrix.scale[MAT.X] = target.x + efficient.width / 2;
	matrix.scale[MAT.Y] = target.y + efficient.height / 2;
	//style
	
	////radius
	target.radius = {};
	target.radius.left = {};
	target.radius.right = {};
	target.radius.left.top = calculate_value(radius.left.top, efficient.height);
	target.radius.left.bottom = calculate_value(radius.left.bottom, efficient.height);
	target.radius.right.top = calculate_value(radius.right.top, efficient.height);
	target.radius.right.bottom = calculate_value(radius.right.bottom, efficient.height);
	
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
function calculate_container(parent = self.parent){
	if (parent == self) position = absolute;
	
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
	generate_layout();
	
	efficient.width = round(target.width + target.padding.left + target.padding.right);
	efficient.height = round(target.height + target.padding.top + target.padding.bottom);
	
	//positioning
	if (position == fixed or position == absolute){
		var xoff = get_anchor(align, efficient.width);
		var yoff = get_anchor(justify, efficient.height);
		
		var pxoff = get_anchor(align, parent.target.width);
		var pyoff = get_anchor(justify, parent.target.height);
		
		if (position == absolute){
			pxoff = get_anchor(align, GUIW);
			pyoff = get_anchor(justify, GUIH);
		}
		
		x = pxoff - xoff;
		y = pyoff - yoff;
	}
	
	//origin of the quad (this will be used for matrix stuff and will be offsted when a layout is generated)
	target.anchorx = get_anchor(self.anchorx, efficient.width);
	target.anchory = get_anchor(self.anchory, efficient.height);
	
	//matrix stuff wont be offseted in the layout and can be used of animations and whatnot
	target.x = target.anchorx;
	target.y = target.anchory;
	
	if (matrix.scale == auto) matrix.scale = matrix_build(target.x, target.y, 0, 0, 0, 0, 1, 1, 1);
	if (matrix.rotation == auto) matrix.rotation = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	//style
	
	////radius
	target.radius.top.left = calculate_value(radius.top.left, efficient.height);
	target.radius.top.right = calculate_value(radius.top.right, efficient.height);
	target.radius.bottom.left = calculate_value(radius.bottom.left, efficient.height);
	target.radius.bottom.right = calculate_value(radius.bottom.right, efficient.height);
	
	////background
	target.background = (is_array(background) or background <= auto) ? get_rgb(c_white) : get_rgb(background);
	
	//create vertex buffer
	if (sprite != auto){
		texture = sprite_get_texture(sprite, image);
		uvs = sprite_get_uvs(sprite, image);
	}
	
	build_quad(uvs);
	
	//matrices
	var fmat = matrix_multiply(matrix.rotation, matrix.scale);
	
	fmat[MAT.X] = x + target.x;
	fmat[MAT.Y] = y + target.y;
		
	target.fmat = fmat;
	target.tmat = matrix_build(0, 0, 0, 0 , 0, 0, 1, 1, 1);
	
	dirty = false;
}
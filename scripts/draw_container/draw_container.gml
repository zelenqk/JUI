function draw_container(cx, cy, container){
	if (container[$ "baked"] != true) container = bake_container(container);
	
	container.tx = cx;
	container.ty = cy;
	
	with (container) {
		draw_rectangle(tx, ty, tx + width, ty + height, false);
	}
}
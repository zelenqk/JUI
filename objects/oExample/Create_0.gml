surface = new Surface(322, 322, true);

if (surface.target()){
	draw_sprite_stretched_ext(sdads, 0, 0, 0, 322, 322, c_white, 1);
	surface.reset();
}

main = new container({
	width: 500,
	height: 300,
	padding: 10,
	
	opacity: 0.6,
	
	direction: row,
	wrap: true,
	
	align: fa_center,
	justify: fa_center,
	
	position: absolute,
	
	background: #121212,
	
	overflow: fa_hidden,
	borderRadius: 12,
	marginLeft: auto,
	
	backdrop: {
		shader: shBlurH,
		pass: shBlurV,
		size: ["width", "height"],
		radius: 24,
	}
});

var knob = {
	borderRadius: "50%",
	height: "100%",
	recalculate: true,
	
	aspect: 1,
	
	arguments: {
		surface: surface,
		holding: false,
		mouse: -1,
		delta: 0,
	},
		
	step: function(){
		if (!holding){
			mouse = hover();
			texture = -1;
			
			if (mouse != -1 and mouse_check_button_pressed(mb_left)){
				holding = true;
				
				delta = (target.x + offset.x) - device_mouse_x_to_gui(mouse);
			}else{
				mouse = parent.hover();
				if (mouse != -1 and mouse_check_button_pressed(mb_left)){
					holding = true;
					delta = -efficient.width / 2;
				}
			}
		}
		
		if (holding){
			if (mouse_check_button_released(mb_left)){
				holding = false;
				return;
			}
			
			surface.check();
			texture = surface.texture;
			
			offset.x = clamp(device_mouse_x_to_gui(mouse) - target.x + delta, 0, parent.realistic.width - efficient.width );
		}
		
	},
};

test = main.add({
	width: "100%",
	height: "10%",
	marginBottom: 10,
	background: c_red,
	
	content: knob,
	
	padding: 3,
	borderRadius: "50%",
	overflow: fa_hidden,
}, 5);

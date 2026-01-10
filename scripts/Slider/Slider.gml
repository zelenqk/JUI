function Slider(style = {borderRadius: "50%", height: "100%", width: 7, background: #161616, padding: 1}, knob = { background: #999999}, parent = self, acceessParent = true) : container(style, parent) constructor{
	
	knob.arguments = {
		holding: false,
		delta: 0,
		along: "x",
		alongCross: "y",
		axisSize: "width",
		crossSize: "height",
		value: 0,
		size: 10,
		position: device_mouse_x_to_gui,
		acceessParent: acceessParent,
	}
	
	knob.height = "100%";
	knob.width = "1%";
		
	if (realistic.width < realistic.height){
		knob.width = "100%";
		knob.height = "1%";
		
		knob.arguments.along = "y";
		knob.arguments.alongCross = "x";
		knob.arguments.crossSize = "width";
		knob.arguments.axisSize = "height";
		knob.arguments.position = device_mouse_y_to_gui;
	}
	
	knob.step = function(){
		scale[$ along] = size;
		
		if (acceessParent and parent.parent.hover() != -1){
			offset[$ along] += (mouse_wheel_down() - mouse_wheel_up()) * 10;
		}
		
		if (!holding){
			mouse = hover();
			texture = -1;
			
			if (mouse != -1 and mouse_check_button_pressed(mb_left)){
				holding = true;
				delta = (target[$ along] + offset[$ along]) - position(mouse)
			}else{
				mouse = parent.hover();
				
				if (mouse != -1 and mouse_check_button_pressed(mb_left)){
					holding = true;
					delta = -efficient[$ axisSize] / 2;
				}
			}
		}
		
		if (holding){
			if (mouse_check_button_released(mb_left)){
				holding = false;
			}
			
			offset[$ along] = clamp(position(mouse) - target[$ along] + delta, 0, parent.realistic[$ axisSize] - (efficient[$ axisSize] * scale[$ along]));
			value = (offset[$ along] / (parent.realistic[$ axisSize] - efficient[$ axisSize]));
		}
		
		offset[$ along] = clamp(offset[$ along], 0, parent.realistic[$ axisSize] - (efficient[$ axisSize] * scale[$ along]));
	}
	
	self.knob = add(knob);
}
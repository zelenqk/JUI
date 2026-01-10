function Slider(style = {borderRadius: "50%", height: "100%", width: 7, background: #161616, padding: 1}, knob = {borderRadius: "50%", background: #999999}) : container(style) constructor{
	
	knob.arguments = {
		holding: false,
		delta: 0,
		along: "x",
		alongCross: "y",
		axisSize: "width",
		crossSize: "height",
		value: 0,
		size: 0.01,
		position: device_mouse_x_to_gui
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
		scale[$ along] = (size * parent.realistic[$ axisSize]);
		show_message(scale[$ along])
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
				return;
			}
			
			offset[$ along] = clamp(position(mouse) - target[$ along] + delta, 0, parent.realistic[$ axisSize] - (efficient[$ axisSize] * scale[$ along]));
			value = (offset[$ along] / (parent.realistic[$ axisSize] - efficient[$ axisSize]));
		}
	}
	
	add(knob);
}
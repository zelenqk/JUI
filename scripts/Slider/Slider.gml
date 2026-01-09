function Slider(style = {borderRadius: "50%", width: "100%", height: 32, background: #161616, padding: 4}, knob = {borderRadius: "50%"}) : container(style) constructor{
	
	knob.arguments = {
		holding: false,
		delta: 0,
	}
	
	knob.aspect = 1;
	
	if (realistic.width < realistic.height){
		knob.width = "100%";
	}else{
		knob.height = "100%";
	}
	
	knob.step = function(){
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
			
			offset.x = clamp(device_mouse_x_to_gui(mouse) - target.x + delta, 0, parent.realistic.width - efficient.width );
		}
	}
	
	add(knob);
}
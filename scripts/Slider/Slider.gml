function Slider(properties = {}, knobStyle = {}, parent = undefined) constructor{
	self.properties = properties;
	
	background = get_default("background", #242424);
	
	width = get_default("width", 10);
	height = get_default("height", "100%");
	position = get_default("position", fixed);
	
	padding = get_default("padding", 2);
	
	align = get_default("align", fa_right);
	
	create = function(){
		var inline = (efficient.width > efficient.height);
		axis = (inline) ? "x" : "y";
		cross = (inline) ? "y" : "x";
		
		axisSize = (inline) ? "width" : "height"
		crossSize = (inline) ? "height" : "width";
		
	}
	
	knob = function(knobStyle, parent) constructor{
		self.properties = knobStyle;
		self.background = #f0f0f0;
		
		self[$ parent.axisSize] = get_default(parent.axisSize, "100%");
		self[$ parent.crossSize] = get_default(parent.crossSize, "100%");
		
		self[$ "scale" + parent.axis] = 0;
		
		create = function(){
			delta = {
				x: 0,
				y: 0,
			};
			
			holding = false;
		}
		
		step = function(){
			scale[$ parent.axis] = (parent.parent.realistic[$ parent.axisSize] / parent.parent.flex[$ parent.axisSize]);
			
			if (holding == false){
				if (hover()){
					alpha = 0.75;
					
					if (device_mouse_check_button_pressed(mouse, mb_any)){
						holding = true;
						
						delta = {
							x: device_mouse_x_to_gui(mouse),	
							y: device_mouse_y_to_gui(mouse),	
						}
					}
				}
			}
			
			if (holding){
				if (device_mouse_check_button_released(mouse, mb_any)){
					holding = false;
					return;
				}
				
				offset[$ parent.axis] += device_mouse_y_to_gui(mouse) - delta[$ parent.axis];
				delta[$ parent.axis] = device_mouse_y_to_gui(mouse);
				
				offset[$ parent.axis] = clamp(offset[$ parent.axis], 0, parent.realistic[$ parent.axisSize] - efficient[$ parent.axisSize] * scale[$ parent.axis]);
			
				parent.parent.contentOffset[$ parent.axis] = -offset[$ parent.axis] / (parent.parent.realistic[$ parent.axisSize] / parent.parent.flex[$ parent.axisSize]);
			}else if (mouse == -1) alpha = 1;
			
		}
	}
	
	holder = new container(self, parent);
	holder.add(new knob(knobStyle, holder))
}
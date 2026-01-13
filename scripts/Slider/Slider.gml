function Slider(properties = {}, knob = {}, parent) constructor{
	self.properties = properties;
	
	background = get_default("background", #323232);
	
	width = get_default("width", 7);
	height = get_default("height", "100%");
	position = get_default("position", fixed);
	
	borderRadius = get_default("borderRadius", "50%");
	align = get_default("align", fa_right);
	
	padding = get_default("padding", 1);
	
	create = function(){
		var inline = (efficient.width < efficient.height);
		axis = (inline) ? "x" : "y";
		cross = (inline) ? "y" : "x";
		
		axisSize = (inline) ? "width" : "height"
		crossSize = (inline) ? "height" : "width";
		
	}
	
	step = function(){
		if (hover()){
				
		}
	}
	
	knob = function(knob, parent) constructor{
		self.properties = knob;
		
		self[$ parent.axisSize] = get_default(parent.axisSize, "100%");
		self[$ parent.crossSize] = get_default(parent.crossSize, "1%");
		
		self[$ "scale" + parent.axis] = 0;
	
		step = function(){
			
		}
	}
	
	holder = new container(self, parent);
}
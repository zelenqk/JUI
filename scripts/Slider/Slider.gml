function Slider(properties = {}, knobStyle = {}, parent = undefined) constructor{
	self.properties = properties;
	
	background = get_default("background", #242424);
	
	width = get_default("width", 10);
	height = get_default("height", "100%");
	position = get_default("position", fixed);
	
	padding = get_default("padding", 3);
	
	borderRadius = get_default("borderRadius", "100%");
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
		
		self[$ parent.axisSize] = get_default(parent.axisSize, "100%");
		self[$ parent.crossSize] = get_default(parent.crossSize, "100%");
		
		self[$ "scale" + parent.axis] = 0;
	}
	
	holder = new container(self, parent);
	holder.add(new knob(knobStyle, holder))
}
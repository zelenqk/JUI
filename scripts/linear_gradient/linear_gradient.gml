function linear_gradient(dir) {	//this is gpt (im sorry)
	var color = [];
	var factor = [];
	var color_count = 0;
	
	for(var i = 1; i < argument_count; i += 2){
		var col = argument[i];
		var fac = argument[i + 1];
		
		col = int_to_bytes(col);
		
		color = array_concat(color, col);
		array_push(factor, fac);
	}
	
	return [shLinearGradient, dir, color, factor];
}

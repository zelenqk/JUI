function linear_gradient(dir) {	//this is gpt (im sorry)
	var gradient = [];
	var color_count = 0;

	// Count number of color/factor arguments passed
	for (var i = 0; i < argument_count - 1; i += 2) {
		color_count += 1;
	}

	// Loop through each color/factor pair
	for (var i = 0; i < argument_count - 1; i += 2) {
		var col = argument[i];
		var f;

		// Check if a factor was provided
		if (i + 1 < argument_count - 1) {
			f = argument[i + 1];
		} else {
			// If no factor, divide the gradient evenly
			f = 1 / color_count;
		}
		
		col = int_to_bytes(col);
		if (col[3] == 0) col[3] = 0xFF;
		
		array_push(gradient, [col, f]);
	}

	return gradient;
}

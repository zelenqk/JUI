function get_overwrites(fallback){
	for(var i = 1; i < argument_count; i++){
		var value = get_default(argument[i], auto);
		if (value != auto) return value;
	}
	
	return fallback;
}
function get_overwrites(fallback){
	for(var i = 1; i < argument_count; i++){
		var value = get_default(argument[i], undefined);
		if (value != undefined) return value;
	}
	
	return fallback;
}
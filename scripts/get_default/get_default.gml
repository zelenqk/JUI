function get_default(name, fallback = auto){
	var value = properties[$ name];
	if (value == undefined) return fallback;
	return value;
}

function get_overwrite(){
	var fallback = argument[argument_count - 1];
	var name, value;
	
	for(var i = 0; i < argument_count - 1; i++){
		name = argument[i];
		value = properties[$ name];
		
		if (is_struct(value)) continue;
		if (value != undefined) return value;		
	}
	
	return fallback;
}

function get_overwrite_struct(){
	var struct = argument[0];
	var fallback = argument[argument_count - 1];
	
	if (!is_struct(properties[$ struct])) return fallback;
	
	var name, value;
	
	for(var i = 1; i < argument_count - 1; i++){
		name = argument[i];
		value = properties[$ struct][$ name];
		if (value != undefined) return value;		
	}
	
	return fallback;
}
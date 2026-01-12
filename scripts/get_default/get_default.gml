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

function get_default_struct(structName, name, fallback = auto){
	var struct = properties[$ structName];
	if (!is_struct(struct) or struct[$ name] == undefined) return fallback;
	
	return struct[$ name];
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

function get_shader_arguments(struct){
	var names = struct_get_names(struct);
	array_delete(names, array_get_index(names, "shader"), 1);
	
	var shader = struct.shader;
	var arguments = [];
	
	for(var i = 0; i < array_length(names); i++){
		var name = names[i];
		var value = struct[$ name];
		
		if (is_array(value)){
			for(var u = 0; u < array_length(value); u++){
				var val = value[u];
				
				if (is_string(val)) value[u] = efficient[$ val];	
			}
		}else value = [value];
		
		var arg = {
			uniform: shader_get_uniform(shader, name),
			value: value,
		}
		
		array_push(arguments, arg);
	}
	
	return arguments;
}
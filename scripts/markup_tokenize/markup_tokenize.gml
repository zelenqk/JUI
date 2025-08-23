function markup_tokenize(text){
	var sectors = string_split(text, "<", true);
	var tokens = [];
	
	for(var i = 0; i < array_length(sectors); i++){
		var sector = sectors[i];
		
		var content = string_split(sector, ">", true, 1);
		
		if (array_length(content) > 1){
			var type = string_split(content[0], " ", true);
			
			var token = array_concat([true], type);
			array_push(tokens, token);
			
			var token = [false, content[1]];
			array_push(tokens, token);
		}else{
			var token = [false, content[0]];
			array_push(tokens, token);
		}
	}
	
	return tokens;
}
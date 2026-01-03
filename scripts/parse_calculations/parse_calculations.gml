enum CALCULATION { PIXEL, PERCENT };

function parse_calculations(){
	calculations = {
		width: get_calculation(width),
		height: get_calculation(height),
		
		fontSize: get_calculation(fontSize)
	}
	
}

function get_calculation(value){
	var type = CALCULATION.PIXEL;
	if (is_real(value)) return {type, value}; 
	
	// TODO: Optimize this crap code block
	var i = 1;
	var input = "";
	var calculator = "";
	repeat (string_length(value)){
		var char = string_char_at(value, i++);
		var ordinal = ord(char);

		if (ordinal > 47 and ordinal < 58) input += char;
		else calculator += char;
	}
	
	input = real(input);
	//-----------------------------------\\
	
	switch (calculator){
	case "":
	case "px":
		type = CALCULATION.PIXEL;
		break;
	case "%":
	case "p":
		type = CALCULATION.PERCENT;
		break;
	}
	
	return {type, input}; 
}

function calculate_value(name){
	var calculation = calculations[$ name];
	var value = calculation.input;
	var type = calculation.type;
	var from = parent.efficient[$ name];
	
	switch (type){
	case CALCULATION.PERCENT:
		value = from * (value) / 100;
		break;
	}
	
	efficient[$ name] = value;
}
enum CALCULATION { PIXEL, PERCENT, VIEW_WIDTH, VIEW_HEIGHT };

function parse_calculations(){
	calculations = {
		width:		get_calculation(width),
		height:		get_calculation(height),
		
		gap:		get_calculation(gap),
		
		opacity:	get_calculation(opacity),
		
		fontSize:	get_calculation(fontSize),
		
		border:		get_calculation(border),
		
		padding: {
			left:	get_calculation(padding.left	),	
			right:	get_calculation(padding.right	),	
			top:	get_calculation(padding.top		),	
			bottom:	get_calculation(padding.bottom	),	
		},
		
		margin: {
			left:	get_calculation(margin.left		),	
			right:	get_calculation(margin.right	),	
			top:	get_calculation(margin.top		),	
			bottom:	get_calculation(margin.bottom	),	
		},
		
		offset: {
			x:		get_calculation(manualOffset.x),
			y:		get_calculation(manualOffset.y),	
		},
		
		borderRadius: (borderRadius == auto) ? auto : {
			topLeft:		get_calculation(borderRadius.topLeft		),	
			topRight:		get_calculation(borderRadius.topRight		),	
			bottomLeft:		get_calculation(borderRadius.bottomLeft		),	
			bottomRight:	get_calculation(borderRadius.bottomRight	),	
		},
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
	
	value = real(input);
	//-----------------------------------\\
	
	switch (string_lower(calculator)){
	case "":
	case "px":
		type = CALCULATION.PIXEL;
		break;
	case "%":
	case "p":
		type = CALCULATION.PERCENT;
		break;
	case "vw":
		type = CALCULATION.VIEW_WIDTH;
		break;
	case "vh":
		type = CALCULATION.VIEW_HEIGHT;
		break;
	}
	
	return {type, value}; 
}

function calculate_value(calculation, from){
	var value = calculation.value;
	var type = calculation.type;
	
	switch (type){
	case CALCULATION.PERCENT:
		return from * (value) / 100;
	case CALCULATION.VIEW_WIDTH:
		return GUIW * (value) / 100;
	case CALCULATION.VIEW_HEIGHT:
		return GUIH * (value) / 100;
	default:
		return value;
	}
}
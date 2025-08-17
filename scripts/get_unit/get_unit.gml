function get_unit(val){
	if (is_real(val) or val == infinity) return {unit: UNIT.PIXEL, value: val};
	
	var length = string_length(val);
	var index = length;
	while (index > 0){
		var char = string_char_at(val, index);
		var orded = ord(char);
		
		if (orded >= 48 and orded <= 57){
			break;
		}
		
		index--;
	}
	
	var value = string_copy(val, 0, index);
	var unit = string_copy(val, index + 1, length - index);
	
	switch (string_lower(unit)){
	case "px":
		unit = UNIT.PIXEL;
		break;
	case "%":
	case "pc":
		unit = UNIT.PERCENT;
		break;
	case "vw":
		unit = UNIT.VIEW_WIDTH;
		break;
	case "vh":
		unit = UNIT.VIEW_HEIGHT;
		break;
	case "tw":
		unit = UNIT.TARGET_WIDTH;
		break;
	case "th":
		unit = UNIT.TARGET_HEIGHT;
		break;
	case "ew":
		unit = UNIT.EFFICIENT_WIDTH;
		break;
	case "eh":
		unit = UNIT.EFFICIENT_HEIGHT;
		break;
	case "pw":
		unit = UNIT.PARENT_WIDTH;
		break;
	case "ph":
		unit = UNIT.PARENT_HEIGHT;
		break;
	default:
		unit = UNIT.PIXEL;
		break;
	}
	
	return {unit: unit, value: real(value)};
}
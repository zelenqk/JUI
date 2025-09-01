enum JUNIT { PIXEL, PERCENT, TARGET_WIDTH, TARGET_HEIGHT, PARENT_WIDTH, PARENT_HEIGHT, PARENT_EWIDTH, PARENT_EHEIGHT };

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
	
	var value = real(string_copy(val, 0, index));
	var unit = string_lower(string_copy(val, index + 1, length - index));
	
	switch (unit){
	default:
		unit = JUNIT.PIXEL;
		break;
	case "%":
		unit = JUNIT.PERCENT;
		break;
	case "tw":
		unit = JUNIT.TARGET_WIDTH;
		break;
	case "th":
		unit = JUNIT.TARGET_WIDTH;
		break;
	case "pw":
		unit = JUNIT.PARENT_WIDTH;
		break;
	case "ph":
		unit = JUNIT.PARENT_WIDTH;
		break;
	case "pew":
		unit = JUNIT.PARENT_EWIDTH;
		break;
	case "peh":
		unit = JUNIT.PARENT_EWIDTH;
		break;
	}
	
	return {value: value, unit: unit}
}
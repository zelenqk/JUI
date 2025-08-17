function calculate_value(value, parentvalue){
	var unit = value.unit;
	value = value.value;
	
	switch (unit){
	case UNIT.PIXEL:
		return value;
		break;
	case UNIT.PERCENT:
		return (value / 100) * parentvalue;
		break;
	case UNIT.VIEW_WIDTH:
		return (value / 100) * GUIW;
		break;
	case UNIT.VIEW_HEIGHT:
		return (value / 100) * GUIH;
		break;
	case UNIT.TARGET_WIDTH:
		return (value / 100) * target.width;
		break;
	case UNIT.TARGET_HEIGHT:
		return(value / 100) * target.height;
		break;
	case UNIT.PARENT_WIDTH:
		return (value / 100) * parent.target.width;
		break;
	case UNIT.PARENT_HEIGHT:
		return(value / 100) * parent.target.height;
		break;
	}	
}

function calculate_radius(value, size){
	var unit = value.unit;
	value = value.value;
	
	switch (unit){
	case UNIT.PIXEL:
		return value / size;
		break;
	case UNIT.PERCENT:
		// Percent unit is capped at 50 real percent to avoid radius overlap/clipping (technically not capped but everything over 100% will be weird)
		return (value / 100) / 2;
		break;
	case UNIT.VIEW_WIDTH:
		return ((value / 100) * GUIW) / GUIW;
		break;
	case UNIT.VIEW_HEIGHT:
		return ((value / 100) * GUIH) / GUIH;
		break;
	case UNIT.PARENT_WIDTH:
		return ((value / 100) * parent.target.width) / parent.target.width;
		break;
	case UNIT.PARENT_HEIGHT:
		return ((value / 100) * parent.target.height) / parent.target.width;
		break;
	}	
}
function calculate_value(value, target = 0){

	switch (value.unit){
	case JUNIT.PIXEL:
		return value.value;
		break;
	case JUNIT.TARGET_WIDTH:
		target = self.target.width;
		break;
	case JUNIT.TARGET_HEIGHT:
		target = self.target.height;
		break;
	case JUNIT.PARENT_WIDTH:
		target = parent.target.width;
		break;
	case JUNIT.PARENT_HEIGHT:
		target = parent.target.height;
		break;
	case JUNIT.PARENT_EWIDTH:
		target = parent.target.width + parent.efficient.width;
		break;
	case JUNIT.PARENT_EHEIGHT:
		target = parent.target.height + parent.efficient.height;
		break;
	case JUNIT.VIEW_WIDTH:
		target = GUIW;
		break;
	case JUNIT.VIEW_HEIGHT:
		target = GUIH;
		break;
	//JUNIT.PERCENT is skipped here
	}
	
	return target * (value.value / 100);
}
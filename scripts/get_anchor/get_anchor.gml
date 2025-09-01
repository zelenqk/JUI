function get_anchor(anchor, size = 1){
	switch (anchor){
	case 1:
		return (size / 2);
		break;
	case 2:
		return size;
		break;
	default:
		return (size * anchor);
		break;
	}
}
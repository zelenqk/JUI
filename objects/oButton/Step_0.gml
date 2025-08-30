mouse = mouse_hover(x, y, width, height);
hover = (mouse != -1);
	
if (hover){
	onHover();	

	if (device_mouse_check_button(mouse, mb_any)) onClick();
	else if (device_mouse_check_button_released(mouse, mb_any)) onRelease();
	
}else onStep();



enum DTARGETS { MOBILE, DESKTOP, CONSOLE };

globalvar DTARGET;
DTARGET = DTARGETS.MOBILE;

switch (os_type){
case os_windows:
case os_linux:
case os_macosx:
	DTARGET = DTARGETS.MOBILE;
	break;
case os_ios:
case os_android:
case os_tvos:
DTARGET = DTARGETS.MOBILE;
	break;
case os_ps4:
case os_ps5:
DTARGET = DTARGETS.CONSOLE;
	break;
}


function button(style) : container(style) constructor{
	object = oButton;
	
}


globalvar MOUSES, MOUSES_N;
if (DTARGET == DTARGETS.MOBILE) MOUSES_N = 10;
else MOUSES_N = 1;

MOUSES = array_create(MOUSES_N, false);

function mouse_hover(tx, ty, w, h){
	for(var i = 0; i < MOUSES_N; i++){
		if (MOUSES[i] == false or device_mouse_check_button(i, mb_any)){
			if (point_in_box(device_mouse_x_to_gui(i), device_mouse_y_to_gui(i), tx, ty, w, h))	return i;
		}
	}
	
	return -1;
}

function point_in_box(px, py, tx, ty, w, h){
	return point_in_rectangle(px - 1, py - 1, tx, ty, tx + w, ty + h);
}
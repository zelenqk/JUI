#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()

//display
#macro fixed 0
#macro flex 1


globalvar BASE_CONTAINER;

//parent of all
BASE_CONTAINER = {
	target: {
		width: 0,
		height: 0,
	}
}
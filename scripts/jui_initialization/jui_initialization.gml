#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()

#macro auto -1

//display
#macro fixed 0
#macro flex 1

//direction
#macro column 0
#macro row 1
#macro columnReverse 2
#macro rowReverse 2

//overflow
#macro fa_allow 0
//#macro fa_hidden 1 (built in to gameamker yay)
#macro fa_wrap 2
#macro fa_hidden_wrap 3

globalvar BASE_CONTAINER;

//parent of all
BASE_CONTAINER = {
	target: {
		width: 0,
		height: 0,
	}
}
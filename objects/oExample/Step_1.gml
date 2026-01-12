/* BEGIN STEP */
var cw = window_get_width();
var ch = window_get_height();
var full = window_get_fullscreen();

if (previous_window_width != cw or previous_window_height != ch or previous_window_fullscreen != full) {
	previous_window_width = cw;
	previous_window_height = ch;
	previous_window_fullscreen = full;
}
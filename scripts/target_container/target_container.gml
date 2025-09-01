/*
	This constructor stores the dimensions, styles and whatnot in pixels
	instead of arbitrary strings and values
*/

function target_container() constructor{
	x = 0;
	y = 0;
	
	width = 0;
	height = 0;
	
	anchorx = 0;
	anchory = 0;
	
	padding = {
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
	}
	
	margin = {
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
	}
	
	//style
	background = [0, 0, 0];
	
	radius = {
		top: {
			left: 0,	
			right: 0,	
		},
		bottom: {
			left: 0,	
			right: 0,	
		}
	}
}
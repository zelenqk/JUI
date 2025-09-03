//3d stuff
#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()

#macro auto -1
#macro k *1000

//display
#macro fixed 0
#macro flex 1

//position
//fixed 0
#macro relative 1
#macro absolute 2

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

//matrix stuff
enum MAT {XSCALE = 0, YSCALE = 4, ZSCALE = 8, X = 12, Y, Z };
#macro identity matrix_build_identity()

globalvar JUI_FORMAT, BASE_CONTAINER;

vertex_format_begin();
vertex_format_add_color();
vertex_format_add_texcoord();
vertex_format_add_position();
JUI_FORMAT = vertex_format_end();

//parent of all
BASE_CONTAINER = {
	parent: self,
	target: {
		x: 0,
		y: 0,
		
		width: GUIW,
		height: GUIH,
		
		anchorx: 0,
		anchory: 0,
	}
}

globalvar uRadius, uSize, uPos;
uRadius = shader_get_uniform(shBorderRadius, "radius");
uSize = shader_get_uniform(shBorderRadius, "size");
uPos = shader_get_uniform(shBorderRadius, "pos");

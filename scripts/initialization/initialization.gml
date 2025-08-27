#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()

//display
#macro fixed 0
#macro flex 1
#macro auto -1
#macro auto_first -2

//position
//fixed
#macro relative 1
#macro hybrid 2

//directions
#macro column 0
#macro row 1
#macro reverseColumn 2
#macro reverseRow 3

//overflow
#macro fa_allow 0
#macro fa_wrap 1
//fa_hidden 2
#macro fa_hidden_wrap 3

enum UNIT { TYPE, VALUE, PIXEL, PERCENT, VIEW_WIDTH, VIEW_HEIGHT, TARGET_WIDTH, TARGET_HEIGHT, EFFICIENT_WIDTH, EFFICIENT_HEIGHT, PARENT_HEIGHT, PARENT_WIDTH };

globalvar BASE_CONTAINER;

BASE_CONTAINER = {
	"position": relative,
	"display": fixed,
	"direction": column,
	"overflow": fa_allow,
	
	"background": c_white,
	
	//boundaries
	"width": 0,
	"height": 0,

	//sprite stuff
	"sprite": -1,
	"image": 0,
	"blend": c_white,
	
	"repetition": false,
	"xscale": 1,
	"yscale": 1,
	
	//styling options
	"marginLeft": 0,
	"marginRight": 0,
	"marginTop": 0,
	"marginBottom": 0,
	
	"paddingLeft": 0,
	"paddingRight": 0,
	"paddingTop": 0,
	"paddingBottom": 0,
	
	"gapLeft": 0,
	"gapRight": 0,
	"gapTop": 0,
	"gapBottom": 0,
	
	"radiusTopLeft": 0,
	"radiusTopRight": 0,
	"radiusBottomLeft": 0,
	"radiusBottomRight": 0,
}

//Font shit
globalvar FONT_SIZES;
FONT_SIZES = [];

var i = 0;
while (font_exists(i)){
	FONT_SIZES[i] = font_get_size(i);
	i++;
}

///SHADER UNIFORMS
//border radius
globalvar uRadius, uSize;

uRadius = shader_get_uniform(shBorderRadius, "radius");
uSize = shader_get_uniform(shBorderRadius, "size");

//blur shader
globalvar uBlurSizeH, uBlurRadiusH, uBlurSizeV, uBlurRadiusV;

uBlurSizeH = shader_get_uniform(shBlurH, "texture_size");
uBlurRadiusH = shader_get_uniform(shBlurH, "blur_radius");
uBlurSizeV = shader_get_uniform(shBlurV, "texture_size");
uBlurRadiusV = shader_get_uniform(shBlurV, "blur_radius");

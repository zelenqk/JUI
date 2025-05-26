/*
	For more information check bake_container function
	all the variable names and their use is explained there
*/

test = {
	"text": "HELLO GAMEMAKER",
	"fontSize": 48,
	"width": 200,
	"height": 80,
	"halign": fa_center,
	"valign": fa_center,
	"background": [c_red, c_blue],
	"textOffsetx": -320,
	"outline": c_white,
	"color": c_white,
	"allowSelect": true,
	"overflow": fa_hidden,
}

var animation = {
	"color": c_white,
	"textOffsetx": 320,
	"type": linear,
	"easing": 0.005,
	"script": function(from, to, ease){
		return clamp(from + ease, from, to);
	}
}

animation.animation = animation;
test.animation = animation;

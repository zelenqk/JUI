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
	"textOffsetx": -80,
	"color": c_white,
	"step": function(){
		text = animation.dir;	
	}
}

var animation = {
	"color": c_white,
	"textOffsetx": 80,
	"background": [c_blue, c_red],
	"type": continuous,
	"easing": 0.01,
	"script": function(from, to, ease){
		return clamp(from + ease, from, to);
	}
}

test.animation = animation;

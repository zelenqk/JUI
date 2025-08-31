globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

/*main = new container({
	"background": #121212,
	"width": 600,
	"height": 400,
	"textAlign": fa_center,
	
	"text": "Huilo kak dela\nTi moi svqt eblan\nQ teb mrazq huilo gandon shalava\nHuiloooooo",
	"color": c_white,
	"halign": fa_center,
});
*/

style = {
	"width": "24%",
	"height": "56%",
	"background": c_black,
	"radius": "8%",
	"opacity": 0.25,
	"align": fa_right,
	"justify": fa_center,
	"display": flex,
	"blur": 24,
	"offsetx": -32,
	"padding": 12,
	"overflow": fa_hidden,
	"maxHeight": "80%",
};

main = new container(style);
main.add({
	"width": "100%",
	"height": auto,
	"radius": "16%",
	"sprite": sJuiLogo,	
	"marginBottom": 12,
});

main.add({
	"width": "100%",
	"display": flex,
	"fontSize": 16,
	"textAlign": fa_center,
	"opacity": 0,
	"halign": fa_center,
	"text": "I gotta say that [rainbow]\nscribble[/rainbow] has to be the best system made in gamemaker it legit has way too many stuff while being incredibly lightweight.\n\nI guess now i'll center anything text based to be controlled by [rainbow]scribble[/rainbow] and dump that btext idea i had, [rainbow]scribble[/rainbow] is just plug and play out of the box\n\nAlso here's 500 containers for the heck of it :P (technically not since when overflow is hidden they are skipped if outside of bounds)"
});

main.add(new button({
	"width": "100%",
	"text": "Rice button",
	"height": auto,
	"radius": "100%",
	"overflow": fa_hidden,
	"fontSize": 32,
	"background": c_black,
	"textAlign": fa_center,
	"expressions": {
		"onHover": function(){
			opacity = lerp(opacity, 0.1, 0.1 * dt);	
		},
		"onStep": function(){
			opacity = lerp(opacity, 0.65, 0.2 * dt);	
		},
		"onClick": function(){
			opacity = lerp(opacity, 0.65, 0.2 * dt);	
		},
	}
}))

repeat(500){
	main.add({
		"width": "100%",
		"height": 32,
		"background": c_red,
	})	
}

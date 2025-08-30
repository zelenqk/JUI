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
	"radius": "100%",
	"opacity": 0.25,
	"align": fa_right,
	"justify": fa_center,
	"display": flex,
	"blur": 24,
	"offsetx": -32,
	"padding": 12,
	"overflow": fa_hidden,
};

main = new container(style);
main.add({
	"width": "100%",
	"height": auto,
	"sprite": sJuiLogo,	
	"marginBottom": 12,
});

main.add({
	"width": "100%",
	"display": flex,
	"opacity": 0,
	"text": "I gotta say that [rainbow]scribble[/rainbow] has to be the best system made in gamemaker it legit has way too many stuff while being incredibly lightweight.\n\nI guess now i'll center anything text based to be controlled by [rainbow]scribble[/rainbow] and dump that btext idea i had, [rainbow]scribble[/rainbow] is just plug and play out of the box\n\nAlso here's 500 containers for the heck of it :P (technically not since when overflow is hidden they are skipped if outside of bounds)"
})

main.add(new button({
	"width": "90%",
	"text": "Rice button",
	"height": auto,
	"radius": "100%",
	"overflow": fa_hidden,
	"background": c_black,
	"expressions": {
		"onHover": function(){
			opacity = lerp(opacity, 0.1, 0.1 * dt);	
		},
		"onStep": function(){
			opacity = lerp(opacity, 0.6, 0.2 * dt);	
		},
	}
}))


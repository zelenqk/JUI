
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
	"width": "32%",
	"height": "32%",
	"direction": row,
	"background": c_black,
	"radius": "32%",
	"opacity": 0.9,
	"sprite": sSprite
};

main = new container(style);

test = main.add({
	"width": "120%",	
	"height": "120%",
	"blur": 23,
	"opacity": 0.75,
	"background": c_black,
});

drawn = false;
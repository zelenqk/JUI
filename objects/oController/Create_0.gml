
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
	"padding": 120,
	"opacity": 1,
	"sprite": sSprite
};

main = new container(style);

test = main.add({
	"width": "100%",	
	"height": "100%",
	"opacity": 0.75,
	"blur": 12,
	"staticBlur": false,
	"background": c_black,
});

drawn = false;

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

main = new container({
	"width": "32%",
	"height": "32%",
	"direction": row,
	"display": flex,
	"background": c_red,
	"padding": 12,

	"gradient": linear_gradient(0, c_white, 0.5, 0x000000ff, 0.5),
});

main.add({
	"sprite": sSprite,
	"display": flex,
});
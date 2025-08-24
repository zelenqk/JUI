
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
	"height": "50%",
	"background": #252287,
	"direction": row,
	"overflow": fa_wrap,
	"radius": "24%",
	"gap": 1,
	"padding": 23,
	"display": flex,
});

var child = {
	"height": "20%",
	"aspect": 1,
	"image": 1,
	"background": #E449C9,
	"text": "hui",
	"alignText": fa_center,
	"justifyText": fa_center,
	"display": flex,
}

var test = {
	"height": "20%",
	"aspect": 1,
	"image": 1,
	"background": #E449C9,
	"alignText": fa_center,
	"justifyText": fa_center,
	"sprite": sSprite,
	"display": flex,
	"spriteXscale": 1.5,
	"spriteYscale": 0.5,
}

main.add(new container(test));




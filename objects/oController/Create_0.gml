
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
	"width": "100%",
	"height": "100%",
	"background": #252287,
	"direction": row,
	"overflow": fa_wrap,
	"radius": "24%",
	"gap": 128,
	"padding": 12,
});

var child = {
	"height": "50%",
	"aspect": 1,
	"image": 1,
	"background": #E449C9,
	"text": "hui",
	"alignText": fa_center,
	"justifyText": fa_center,
}

repeat(12){
	var element = new container(child);
	main.add(element);
}


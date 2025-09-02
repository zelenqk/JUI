globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "100%",
	"height": "12%",
	
	"radius": "50%",
	"sprite": sSprite,
	"opacity": 0.25,
	
	"overflow": fa_hidden,
});


repeat(3000){
	main.add({
		"radius": "50%",
		"width": 300,
		"height": "50%",
		"background": c_red,
	})	
}
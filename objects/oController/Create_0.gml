globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "100%",
	"height": "32%",
	
	"radius": 48,
	"sprite": sSprite,
	"opacity": 0.25,
	
	"overflow": fa_hidden,
});


repeat(2000){
	main.add({
		"radius": 32,
		"width": 300,
		"height": 123,
		"background": c_red,
	})	
}
globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "50vw",
	"height": "32vw",
	
	"radius": "50%",
	"sprite": sSprite,
	"opacity": 0.25,
	"align": fa_center,
	"justify": fa_center,
	
	"padding": 32,
	"overflow": fa_hidden,
});

repeat(12){
	main.add({
		"width": "50%",	
		"height": "50%",
		"background": c_red,
		"radius": "10%",
		
		"position": fixed,
		"align": fa_center,
		"justify": fa_center,
	})
}

rotation = 0;


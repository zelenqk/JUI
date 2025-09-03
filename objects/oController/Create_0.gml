globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "32vw",
	"height": "32vw",
	
	"radius": "12%",
	"sprite": sSprite,
	"opacity": 0.25,
	
	"perspective": true,
	"overflow": fa_hidden,
});

repeat(3){
	main.add({
		"width": "50%",	
		"height": "50%",
		"background": c_red,
	})
}

rotation = 0;


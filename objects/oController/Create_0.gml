globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "100vw",
	"height": "32vw",
	
	"radius": "50%",
	"sprite": sSprite,
	"opacity": 0.25,
	
	"anchorx": fa_right,
	
	"perspective": true,
	"overflow": fa_hidden,
});

repeat(2000){
	main.add({
		"width": "50%",	
		"height": "50%",
		"background": c_red,
		"radius": "10%",
	})
}

rotation = 0;


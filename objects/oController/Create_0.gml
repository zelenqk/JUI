globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "100%",
	"height": "32%",
	
	"background": c_red,
	
	"sprite": sSprite,
	"opacity": 0.25,
	
	"overflow": fa_hidden,
});

main.add(new container({
	"width": "50%",
	"height": "24%",
	
	"background": c_blue,
	"sprite": sJuiLogo,
}))

rotation = 0;
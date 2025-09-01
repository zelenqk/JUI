globalvar dt;
targetDt = 1 / 60;
dt = (delta_time / targetDt) / 1000000;

main = new container({
	"width": "100%",
	"height": "12%",
	
	"background": c_white,
});

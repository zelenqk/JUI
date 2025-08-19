main = new container({
	"width": 300,
	"height": "50%",
	"background": c_red,
	"direction": row,
	"overflow": fa_wrap,
	"radius": "10%",
	"padding": 12,
	"display": flex,
});

var child = {
	"height": "24%",
	"aspect": 1,
	"image": 1,
}

repeat(4){
	var element = new container(child);
	main.add(element);
}




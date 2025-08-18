main = new container({
	"width": 300,
	"height": "50%",
	"background": c_red,
	"direction": row,
	"overflow": fa_hidden_wrap,
	"padding": 24,
	"radius": 32,
	"aspect": 1,
	"gap": auto,
});

var child = {
	"width": "25%",
	"height": "25%",
	"image": 1,
}

repeat(9){
	var element = new container(child);
	main.add(element);
}



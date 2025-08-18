main = new container({
	"width": 300,
	"height": "50%",
	"background": c_red,
	"direction": row,
	"overflow": fa_hidden_wrap,
	"padding": 24,
	"radius": 32,
	"aspect": 1,
	"gap": auto_first,
});

var child = {
	"width": "12%",
	"height": "12%",
	"image": 1,
}

repeat(12){
	var element = new container(child);
	main.add(element);
}



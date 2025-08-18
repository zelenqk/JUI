main = new container({
	"width": 300,
	"height": "50%",
	"background": c_red,
	"direction": row,
	"overflow": fa_hidden_wrap,
	"padding": 24,
	"radius": "50%",
	"gap": auto_first,
	"aspect": 1,
});

var child = {
	"height": "24%",
	"aspect": 1,
	"image": 1,
}

repeat(16){
	var element = new container(child);
	main.add(element);
}



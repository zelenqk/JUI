main = new container({
	"width": 300,
	"height": "50%",
	"background": c_red,
	"direction": row,
	"padding": 64,
	"radius": "10%",
	"gap": auto_first,
	"display": flex,
});

var child = {
	"height": "24%",
	"aspect": 1,
	"radius": "100%",
	"image": 1,
}

repeat(16){
	var element = new container(child);
	main.add(element);
}



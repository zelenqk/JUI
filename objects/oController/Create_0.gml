main = new container({
	"width": 300,
	"height": "50%",
	"background": c_red,
	"direction": row,
	"overflow": fa_hidden_wrap,
	"radius": "12%",
	"gap": 3,
	"display": flex,
});

var bg = new container({
	"width": "100%",
	"height": "100%",
	"background": c_blue,
	"position": fixed,
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

main.add(bg, 0);




main = new container({
	background: #121212,
	width: "50%",
	height: "50%",
	
	direction: column,
	opacity: "50%",
	
	align: fa_center,
	justify: fa_center,
	overflow: fa_hidden,
	
	borderRadius: "5%",
	padding: 32,
	wrap: true,
});


child = main.add({height: "32%", marginTop: auto, marginRight: 1, aspect: 1, background: #0000FF}, 10);

child[0].step = function(){
	contentOffset.y += 0.001;	
}

child[0].overflow = fa_hidden;
child[0].calculate();
child[0].add({
	width: "50%",
	height: "50%",
	background: c_red,
	borderRadius: "50%",
});




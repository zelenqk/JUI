main = new container({
	color: #121212,
	width: "50%",
	height: "50%",
	
	direction: column,
	
	align: fa_center,
	justify: fa_center,
	overflow: fa_hidden,
	
	borderRadius: 32,
	padding: 32,
	wrap: true,
});


child = main.add({height: "32%", marginTop: auto, overflow: fa_hidden, marginRight: 1, aspect: 1, background: #0000FF, step: function(){
		if (hover()) alpha = lerp(alpha, 0.5, 0.01)
		else alpha = lerp(alpha, 1, 0.01);
	}}, 10);

child[0].add({
	width: "50%",
	height: "50%",
	background: c_red,
	borderRadius: "50%",
	overflow: fa_hidden,
	
	step: function(){
		if (hover()) alpha = lerp(alpha, 0.5, 0.01)
		else alpha = lerp(alpha, 1, 0.01);
	}
});


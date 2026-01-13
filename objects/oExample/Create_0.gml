main = new container({
	background: #121212,
	width: "50%",
	height: "50%",
	
	direction: column,
	
	align: fa_center,
	justify: fa_center,
	overflow: fa_scroll,
	
	borderRadius: 32,
	padding: 32,
	wrap: true,
	
	step: function(){
	}	
});

child = main.add({height: "200%", width: 32, marginRight: 1, background: #0000FF, step: function(){
		if (hover()) alpha = lerp(alpha, 0.5, 0.01)
		else alpha = lerp(alpha, 1, 0.01);
	}}, 11);

child[0].add({
	width: "50%",
	height: "50%",
	
	step: function(){
		if (hover()) alpha = lerp(alpha, 0.5, 0.01)
		else alpha = lerp(alpha, 1, 0.01);
	}
});

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


child = main.add({height: "32%", overflow: fa_hidden, marginTop: auto, marginRight: 1, aspect: 1, background: #0000FF}, 10);

child[0].step = function(){
	if (hover()){
		alpha = 0.1;
	}else{
		alpha = 1;	
	}
}

child[0].calculate();
child[0].add({
	width: "50%",
	height: "50%",
	background: c_red,
	borderRadius: "50%",
});




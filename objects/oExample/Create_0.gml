main = new container({
	background: #121212,
	width: "50%",
	height: "50%",
	
	direction: column,
	
	step: function(){
		contentOffset.y += 0.01;	
	}
});


	
child = main.add({height: "10%", aspect: 1, background: #0000FF, step: function(){
		
	
	}
}, 10);

child = main.add({position: fixed, margin: auto, height: "10%", aspect: 1, background: #FF0000});

previous_window_width = window_get_width();
previous_window_height = window_get_height();
previous_window_fullscreen = window_get_fullscreen();

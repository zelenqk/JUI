main = new container({
	background: #121212,
	width: "50%",
	height: "50%",
	
	direction: row,
	
	wrap: true,
});


child = main.add({width: "10%", aspect: 1, background: #0000FF, step: function(){
		
	
	}
}, 10);

previous_window_width = window_get_width();
previous_window_height = window_get_height();
previous_window_fullscreen = window_get_fullscreen();

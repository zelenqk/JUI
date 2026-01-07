surface = new Surface(100, 100, true);

if (surface.target()){
	draw_sprite_stretched_ext(sTest, 0, 0, 0, 100, 100, c_white, 1);
	surface.reset();
}

main = new container({
	width: "40%",
	height: "20%",
	padding: "1%",
	background: surface,
	borderRadius: "50%",
	step : function(){
		contentoffset.y -= 0.1;	
	},
	
	overflow: fa_hidden,
	
	anchor: 0,
	
	wrap: true,
});

test = main.add(new container({
	width: "100%",
	height: 64,
	opacity: 0.5,
	background: c_blue,
	margin: {
		bottom: 4	
	}
}), 100);


function draw_overflow(tx = 0, ty = 0){
	cache.overflow.target(){
		gpu_set_blendenable(false);
		draw_clear_alpha(c_black, 0);
		
		draw_content(content, target.padding.left, target.padding.top);	
		if (text != -1) text.draw(target.padding.left, target.padding.top);	
		gpu_set_blendenable(true);
		
		gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
		cache.background.draw(0, 0);
		gpu_set_blendmode(bm_normal);
	}
	
	cache.overflow.reset();
	cache.overflow.draw(tx, ty);
}

function draw_vanilla(tx = 0, ty = 0){
	draw_content(content, tx + target.padding.left, ty + target.padding.top);	
	if (text != -1) text.draw(tx + target.padding.left, ty + target.padding.top);	
}

//text stuff
	
	/*	if (text != ""){
				var textOffsetX = 0;
				var textOffsetY = 0;
				
				switch (alignText){
				case fa_center:
					textOffsetX = (target.width / 2) - text.width / 2;
					break;
				case fa_right:
					textOffsetX = (target.width - text.width);
					break;
				default:
					textOffsetX = (target.width * alignText) - text.width * alignText;
					break;
				}
				
				
				switch (justifyText){
				case fa_center:
					textOffsetY = (target.height / 2) - text.height / 2;
					break;
				case fa_bottom:
					textOffsetY = (target.height - text.height);
					break;
				default:
					textOffsetY = (target.height * justifyText) - text.height * justifyText;
					break;
				}

				text.draw(x + tx + target.padding.left + textOffsetX, y + ty + target.padding.top + textOffsetY);
			}*/
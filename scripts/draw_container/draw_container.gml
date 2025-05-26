/*
	JUI is a struct based UI system for gamemaker written and made by zelenqk (me)
	inspired by css's style of using structs
	
	Hopefully this is my final rewrite and its smooth sailing from there
*/


function draw_container(tx, ty, container){
	if (container[$ "baked"] != true) bake_container(container);
	if (container.draw != true) return;
	
	container.tx = tx;
	container.ty = ty;
	
	with (container) {
		//NOTE: for some reason rectangles are offsetted by 1 unit (if outline its [-1, -1, +1, +1] and for normal rectangles its [0, 0, +1, +1]) idk why
		//gamemaker sure loves its offsets and i wouldnt love it without them
		var a = draw_get_alpha();
		if (container.parent == container){
			tw = GUIW;
			th = GUIH;
		}
		
		play_animation();
		
		if (display == flex){
			tw = twidth;	
			th = theight;
			
			twidth = 0;
			theight = 0;
		}else{
			tw = width;	
			if (is_string(self.width)) {
				tw = real(parent.tw) * (real(self.width) / 100);
			}
			
			th = height;
			if (is_string(self.height)) {
				th = real(parent.th) * (real(self.height) / 100);
			}	
		}
		
		self.tx += left + (right != 0) * (parent.tw - twidth - right) + marginLeft;
		self.ty += top + (bottom != 0) * (parent.th - theight - bottom) + marginTop;
		
		ex = paddingLeft;
		ey = paddingTop;
		
		if (!wrapped){
			boundaries.x = self.tx;	
			boundaries.y = self.ty;
			boundaries.w = tw + 1;
			boundaries.h = th + 1;
		}else{
			boundaries.x = max(parent.boundaries.tx, self.tx);
			boundaries.y = max(parent.boundaries.ty, self.ty);
			boundaries.w = min(boundaries.x + parent.boundaries.w, boundaries.x + tw) + 1 - boundaries.x;
			boundaries.h = min(boundaries.y + parent.boundaries.h, boundaries.y + tw) + 1 - boundaries.y;
		}
		
		if (is_array(bgcol)){
			draw_set_alpha(opacity);
			
			//update background color
			if (is_array(background)){
					var colN = array_length(background);
					
					switch (colN){
					case 1: bgcol = [background[0], background[0], background[0], background[0]]; break;
					case 2: bgcol = [background[0], background[1], background[1], background[0]]; break;
					case 3: bgcol = [background[0], background[1], background[2], background[0]]; break;
					case 4: bgcol = [background[0], background[1], background[2], background[3]]; break;
				}
			}else{
				bgcol = [background, background, background, background]	
			}
			
			draw_rectangle_color(self.tx, self.ty, self.tx + tw, self.ty + th,
								 container.bgcol[0],
								 container.bgcol[1],
								 container.bgcol[2],
								 container.bgcol[3],
								 false);
		}

		
		if (is_array(outline)){
			draw_line_width_color(self.tx - thickness, self.ty - thickness / 2, self.tx + tw, self.ty - thickness / 2, thickness, outline[0], outline[1]);						//top left > top right
			draw_line_width_color(self.tx + tw + thickness / 2, self.ty - thickness, self.tx + tw + thickness / 2, self.ty + th, thickness, outline[3], outline[2]);	//top right > bottom right
			draw_line_width_color(self.tx + tw + thickness, self.ty + th + thickness / 2, self.tx, self.ty + th + thickness / 2, thickness, outline[2], outline[3]);	//bottom right > bottom left
			draw_line_width_color(self.tx - thickness / 2, self.ty + th + thickness, self.tx - thickness / 2, self.ty, thickness, outline[0], outline[1]);	//bottom left > top left
		}
				
				
		draw_set_alpha(a);
		
		////overflow
		var state = gpu_get_scissor();	//save current gpu state
		if (container.overflow == fa_hidden) gpu_set_scissor(container.boundaries);	//push desired gpu state
		
		step(state);
		
		if (container.overflow == fa_hidden) gpu_set_scissor(container.boundaries);	//push desired gpu state (if you resetted it in the step event)
		
		////TEXT
		var fnt = draw_get_font();
		draw_set_font(font);
		
		var textScale = (fontSize / string_height("|"));
		
		var tex = self.tx + ex + textOffsetx;
		var tey = self.ty + ey + textOffsety;
		
		var h = draw_get_halign();		
		var v = draw_get_valign();
		
		draw_set_halign(halign);
		draw_set_valign(valign);
		
		switch (halign){
		case fa_center:
			tex += tw / 2;
			break;
		case fa_right:
			tex += tw;
			break;
		}
		
		switch (valign){
		case fa_center:
			tey += th / 2;
			break;
		case fa_bottom:
			tey += th;
			break;
		}
		
		if (font > -1) font_enable_effects(font, true, fontEffects);
		
		draw_string(text, tex, tey, textScale, 0);
		
		draw_set_halign(h);
		draw_set_valign(v);
		
		if (font > -1) font_enable_effects(font, true, defaultFontEffects);
		
		//if selected copy to clipboard on shortcut (ctrl + c)
		if (keyboard_check_pressed(ord("C")) and keyboard_check(vk_control) and allowSelect){
			var clipboard = "";
			
			if (is_array(text)){
				for(var i = 0; i < array_length(highlight); i++){
					if (highlight[i][0] > -1 and highlight[i][1] > -1 and highlight[i][0] != highlight[i][1]){
						var start = min(highlight[i][0], highlight[i][1]);
						var finish = max(highlight[i][0], highlight[i][1]);
						
						clipboard += string_copy(text[i], start, finish - start);
					}
				}
			}else{
				if (highlight[0][0] > -1 and highlight[0][1] > -1 and highlight[0][0] != highlight[0][1]){
					var start =  min(highlight[0][0], highlight[0][1]) + 1;
					var finish = max(highlight[0][0], highlight[0][1]);
					
					clipboard += string_copy(text, start, 1 + finish - start);
				}
			}
			
			if (clipboard != "") clipboard_set_text(clipboard);
		}
		
		//COLLISION
		mouse = mouse_in_box(boundaries);
		if (mouse != noone){
			hover = true;
			window_set_cursor(cursor);
		}else if (hover){
			window_set_cursor(cr_default);
			hover = false;
		}
		
		//CHILDREN
		switch (alignItems){
		case fa_center:
			ex = tw / 2 - twidth / 2;
			break;
		case fa_right:
			ex = tw - twidth;
			break;
		}
		
		switch (justifyContent){
		case fa_center:
			ey = th / 2 - theight / 2;
			break;
		case fa_right:
			ey = th - theight;
			break;
		}
		
		draw_element(container, container.content);

		//RESET
		var str = [text];
		if (is_array(text)) str = string_concat_ext(text);
		
		twidth = max(twidth, string_width(text) * textScale);
		theight = max(theight, string_height(text) * textScale);
		
		draw_set_font(fnt);
		gpu_set_scissor(state);	//reset gpu
	}
}

function draw_element(parent, content){
	if (is_array(content)){
		var elmN = array_length(content);
		
		for(var i = 0; i < elmN; i++){
			draw_element(parent, content[i]);	
		}
		
		// Sort by depth if needed
		array_sort(content, function(e1, e2){
			return (e2.depth - e1.depth);
		});
	}else{
		content.parent = parent;
		draw_container(parent.contentOffsetx + parent.tx + parent.ex, parent.contentOffsety + parent.ty + parent.ey, content);
		
		if (content.position == relative){
			switch (parent.direction){
			case row:
				// Place children left to right, accumulate total width, keep max height
				parent.ex += content.tw + content.marginLeft + content.marginRight; // advance offset by child's width
				parent.twidth += content.tw + content.marginLeft + content.marginRight; // accumulate total width
				parent.theight = max(parent.theight, content.th); // max height of children
				break;
			case column:
				// Place children top to bottom, accumulate total height, keep max width
				parent.ey += content.th + content.marginTop + content.marginBottom; // advance offset by child's height
				parent.theight = parent.ey + content.marginTop + content.marginTop; // accumulate total height
				parent.twidth = max(parent.twidth, content.tw); // max width of children
				break;
			}
		}
	}
}


function point_in_box(px, py, boundaries){
	return (point_in_rectangle(px, py, boundaries.x, boundaries.y, boundaries.x + boundaries.w + 1, boundaries.y + boundaries.h + 1))
}

function mouse_in_box(boundaries){
	var i = 0;
	
	repeat (4){
		if point_in_box(device_mouse_x_to_gui(i), device_mouse_y_to_gui(i), boundaries) return i;
		i++
	}
	
	return noone;
}

function draw_string(text, tx, ty, scale = 1, index = 0){
	if (is_array(text)){		//recursion
		for(var i = 0; i < array_length(text); i++){
			draw_string(text[i], tx, ty + string_height("A") * (scale * i), scale, i);
		}
	}else{	//render
		if (allowSelect){
			if (!highlighting) highlight[index] = [-1, -1];
			
			var offx = 0;
			var offy = 0;
			
			switch (halign){
			case fa_center:
				offx = (string_width(text) * scale) / 2
				break;
			case fa_right:
				offx = (string_width(text) * scale)
				break;
			}
			
			switch (valign){
			case fa_center:
				offy = (string_height(text) * scale) / 2
				break;
			case fa_right:
				offy = (string_height(text) * scale)
				break;
			}
			
			if (mouse_check_button_pressed(mb_any)) highlighting = false;
			
			if (device_mouse_check_button_pressed(mouse, mb_any)){
				highlight[index][0] = get_char_at(text, tx - offx, ty - offy, device_mouse_x_to_gui(mouse), device_mouse_y_to_gui(mouse), string_width("A") * scale, string_height("A") * scale);
				highlighting = true;
			}
			
		
			if (device_mouse_check_button(mouse, mb_any) and highlighting){
				highlight[index][1] = get_char_at(text, tx - offx, ty - offy, device_mouse_x_to_gui(mouse), device_mouse_y_to_gui(mouse), string_width("A") * scale, string_height("A") * scale);
			}
			
			if (highlight[index][0] >= 0 and highlight[index][1] >= 0 and highlight[index][0] != highlight[index][1]){
				var a = draw_get_alpha();
				
				var start =  min(highlight[index][0], highlight[index][1]);
				var finish = max(highlight[index][0], highlight[index][1]);
				
				var strh = string_height("A") * scale;
				
				var startx = string_width(string_copy(text, 0, start));
				var finishx = string_width(string_copy(text, 0, finish));
				
				draw_set_alpha(0.25);
				
				draw_rectangle_color(tx - offx + startx * scale + 1, ty - offy + 1,
									 tx - offx + finishx * scale - 1, ty - offy + strh - 1,
									 c_aqua, c_aqua, c_aqua, c_aqua, false);
				
				draw_set_alpha(a);
			}
		}

		draw_text_transformed_color(tx, ty, text, scale, scale, 0, color, color, color, color, alpha);	
	}
}

function play_animation(){
	if (!is_struct(animation)) return;

	if (animation[$ "animated"] != true){
		bake_animation(animation);
	}
	
	if (animation.dir == 0) return;
	
	animation.timer = animation.script(animation.timer, 1, animation.easing * delta);
	
	var finished = (animation.timer == 1);
	
	for(var i = 0; i < animation.namesN; i++){
		var name = animation.names[i];
		var value = animation[$ name];
		var def = animation.defined[$ name];
		
		if (value == undefined or def == undefined) continue;
		
		var from = def;
		var to = value;
		
		if (animation.dir == -1){
			from = value;
			to = def;
		}

		switch (name){
		case "background":
		case "outline":
		case "color":
			if (is_array(from)){
				for(var u = 0; u < array_length(animation.defined[$ name]); u++){
					self[$ name][u] = merge_color(from[u], to[u], animation.timer);
				}
			}else{
				self[$ name] = merge_color(from, to, animation.timer);
			}
			break;
		default:
			if (is_string(self[$ name])){
				//
			}else{
				self[$ name] = from + (to - from) * animation.timer;
			}
			break;
		}
	}
	
	if (finished){
		animation.timer = 0;
		
		switch (animation.type){
		case linear:
			animation.dir = 0;
			break;
		case boomerang:
			animation.dir *= -1 * (animation.played < 1);
			animation.played++;
			break;
		case continuous:
			animation.dir *= -1;
			break;
		}
	}
}

function bake_animation(animation){
	var names = variable_struct_get_names(animation);
	var namesN = array_length(names);
	animation.names = [];
	animation.namesN = 0;
	animation.defined = {}; // <-- FIXED: store defined inside animation

	for (var i = 0; i < namesN; i++){
		var name = names[i];
		
		switch (name){
		case "type":
		case "script":
		case "easing":
			break;
		default:
			if (is_array(self[$ name])){
				animation.defined[$ name] = [];
				
				for(var u = 0; u < array_length(self[$ name]); u++){
					animation.defined[$ name][u] = self[$ name][u];	
				}
				animation.names[array_length(animation.names)] = name;
			}else if (!is_struct(self[$ name])){
				animation.defined[$ name] = self[$ name];
				animation.names[array_length(animation.names)] = name;
			}
			break;
		}
	}
	
	animation.namesN = array_length(animation.names);

	if (animation[$ "script"] == undefined){
		animation.script = lerp;
	}
	if (animation[$ "easing"] == undefined){
		animation.easing = 0.1;
	}
	if (animation[$ "type"] == undefined){
		animation.type = linear;
	}

	animation.played = 0;
	animation.dir = 1;
	animation.animated = true;
	animation.timer = 0;
	
	animation.play = function(){
		played = 0;
		dir = 1;
		
	}
}

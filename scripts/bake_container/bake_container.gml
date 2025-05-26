#macro fa_allow noone	//there is fa_hidden but not fa_allow so...

//position
#macro relative 0	//increments with siblings
#macro fixed 1		//uses parent's position
#macro absolute 2	//uses its own position and ignores culling if outside of parent's boundaries

//display
#macro flex 0		//flexible container type

//animations
#macro linear 0		//only goes in one direction
#macro boomerang 1	//goes forth and back
#macro continuous 2	//repeats until stopped (default)

//direction
#macro column 0
#macro row 1

#macro GUIW display_get_gui_width()
#macro GUIH display_get_gui_height()

#macro delta (delta_time / (1 / 60)) / 1000000

globalvar baseContainer, baseContainerNames, baseContainerNamesN, defaultFontEffects, emptySprite;

baseContainer = {
	"draw": true,					//whether to draw the container or skip
									
	"width": 0,						//the width of the container
	"height": 0,					//the height of the container
	"background": noone,			//the background color (can be an array of colors for gradient if only two values are provided the gradient will go from left to right)
	"overflow": fa_allow,			//whether to hide/cull content outside of boundaries (inputs: fa_allow, fa_hidden)
	"position": relative,			//position of container (check lines 4,5,6)
	"display": fixed,				//the display type of the container (can grow or shrink depending on the text inside it or its children, check line 9)
	"outline": false,				//whether the container should have an outline
	"thickness": 1,					//the outline's thickness in pixels
	"left": 0,						//the offset of the container on the x+ axis
	"top": 0,						//the offset of the container on the y+ axis
	"right": 0,						//the offset of the container on the x- axis
	"bottom": 0,					//the offset of the container on the y- axis
	"animation": -1,				//the name of the current animation to play (-1 to stop)
	"tw": 0,
	"th": 0,
	
	/* animation format
		{
			"left": 10,				//the offset from the left to lerp to
			"background": c_green	//this variable is defined a color so it will use merge_color()
			//color interpolation is broken due to floating points i think idk whatever
			//so the animation will skip the check to see if the interpolation for a color variable is finished
			///also it doesnt work with array color values
			
			"definde": {			
			
			},
			"script": {
				"index": lerp,		//you could use a custom function
				"smoothing": 0.1	//the amount of smoothing (gets multiplied by delta time)
				"tpye": continuous	//check lines 12, 13, 14
			}
		}
	*/
	
	"alignItems": fa_left,			//children alignment on the x axis
	"justifyContent": fa_left,		//children alignment on the y axis
	"contentOffsetx": 0,			//children offset on the x axis
	"contentOffsety": 0,			//children offset on the y axis
	"direction": column,
	
	//margin
	"marginLeft": 0,
	"marginTop": 0,
	"marginRight": 0,
	"marginBottom": 0,
	
	//padding
	"paddingLeft": 0,
	"paddingTop": 0,
	"paddingRight": 0,
	"paddingBottom": 0,

	
	//reserved for display type flex
	"maxWidth": infinity,	
	"maxHeight": infinity,
	"minWidth": -infinity,
	"minHeihgt": -infinity,
	
	//text properties
	"text": [],				//the text to draw (an array of text for newlining)
	"color": c_white,		//the text's color
	"fontSize": 24,			//font size
	"textFit": false,		//whether to fit/clamp the text to match the width of the container (doesnt change the font size)
	"alpha": 1,				//the alpha of the text (text transparency)
	"font": defaultFont,	//the font of the text
	"halign": fa_left,		//horizontal alignment of text
	"valign": fa_top,		//vertical alignment of text
	"fontEffects": {},		//font effects (check https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Reference%2FAsset_Management%2FFonts%2Ffont_enable_effects.htm)
	"textOffsetx": 0,		//the text offset relative to the parent's position on the x axis
	"textOffsety": 0,		//the text offset relative to the parent's position on the y axis
	"allowSelect": false,	//weather to allow selection of text
	"opacity": 1,			//the opacity of the background (alpha)
	//children
	"content": [],			//children list (can be just a single struct aswell)
	
	//interactive properties (DO NOT SET)
	"cursor": cr_default,	//the cursor to be set when mouse is hovering
	"step": function(){},	//gets called every step (the first argument is pre-scissor so if you draw anything in the step event it will be scissored you can circumvent that by using the state element)
	"hover": false,			//whether a mouse is hovering over the container
	"mouse": noone,			//which mouse index is hovering over the container
	
	//built-in (DO NOT SET)
	"tw": 0,				//target width
	"th": 0,				//target width
	"tx": 0,				//target x
	"ty": 0,				//target y
	"twidth": 0,			//target width
	"bgcol": noone,			//background color
	"theight": 0,			//target height
	"ex": 0,				//effective x
	"ey": 0,				//effective y
	"textDirty": false,		//whether the text can be updated every frame
	"textBaked": false,		//whether the text has been baked for efficient line selection
	"textChanges": [],		//where the text has changed exactly
	"highlight": [[-1, -1]],//the selected start letter and end letter for text selection
	"depth": 0,				//after all siblings are rendered they get sorted by highest depth first
	"wrapped": false,		//if the current container is a child of another container
	"boundaries": {			//container's boundaries (if wrapped it will be clamped to parent's boundaries)
		"x": 0,
		"y": 0,
		"w": 0,
		"h": 0,
	},
	"highlighting": false,	//wheter the text of the container is currently being highlighted
	"baked": true,			//wether the container is baked or not
}

baseContainer.parent = baseContainer; //cheeky recursion

defaultFontEffects = {
	"outlineEnable": false,
	"glowEnable": false,
	"dropShadowEnable": false,
	"thickness": 0,
	"coreColour": c_white,
	"coreAlpha": 1,
}

baseContainerNames = variable_struct_get_names(baseContainer);
baseContainerNamesN = array_length(baseContainerNames);

//this could cause a memory leak not a big one but if cecil saw it id be embarassed
//var surface = surface_create(1, 1);
//emptySprite = sprite_create_from_surface(surface, 0, 0, 1, 1, false, 1, 0, 0);
//surface_free(surface);

function bake_container(container){
	var newnames = variable_struct_get_names(container);
	
	for(var i = 0; i < array_length(newnames); i++){
		var name = newnames[i];
		
		switch (name){
		case "marginH":
			container.marginLeft = container.marginH;
			container.marginRight = container.marginH;
			break;
		case "marginV":
			container.marginTop = container.marginV;
			container.marginBottom = container.marginV;
			break;
		case "margin":
			container.marginLeft = container.margin;
			container.marginRight = container.margin;
			container.marginTop = container.margin;
			container.marginBottom = container.margin;
			break;
		case "paddingH":
			container.paddingLeft = container.paddingH;
			container.paddingRight = container.paddingH;
			break;
		case "paddingV":
			container.paddingTop = container.paddingV;
			container.paddingBottom = container.paddingV;
			break;
		case "padding":
			container.paddingLeft = container.padding;
			container.paddingRight = container.padding;
			container.paddingTop = container.padding;
			container.paddingBottom = container.padding;
			break;	
		}
	}
	
	for(var i = 0; i < baseContainerNamesN; i++){
		var name = baseContainerNames[i];
		var element = container[$ name];
		
		if (element == undefined) container[$ name] = baseContainer[$ name];
		else{
			switch (name){
			case "background":
				if (is_array(element)){
					var colN = array_length(element);
					
					switch (colN){
					case 1: container.bgcol = [element[0], element[0], element[0], element[0]]; break;
					case 2: container.bgcol = [element[0], element[1], element[1], element[0]]; break;
					case 3: container.bgcol = [element[0], element[1], element[2], element[0]]; break;
					}
				}else{
					container.bgcol = [element, element, element, element];	
				}
				break;
			case "outline":
				if (is_array(element)){
					var colN = array_length(element);
					
					switch (colN){
					case 1: container.outline = [element[0], element[0], element[0], element[0]]; break;
					case 2: container.outline = [element[0], element[1], element[1], element[0]]; break;
					case 3: container.outline = [element[0], element[1], element[2], element[0]]; break;
					case 4: container.outline = [element[0], element[1], element[2], element[4]]; break;
					}
				}else{
					container.outline = [element, element, element, element];	
				}
				break;
			}
		}
	}
	
	container.highlight = [];
	container.parent = container;
	
	return container;
}
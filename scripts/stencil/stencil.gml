function stencil_prepare(){
	draw_clear_stencil(mask);
	
	gpu_set_stencil_enable(true);
	gpu_set_stencil_write_mask(mask);
	gpu_set_stencil_pass(stencilop_replace);
	
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);
	gpu_set_colorwriteenable(false, false, false, false);
	
}

function stencil_set(){
	gpu_set_colorwriteenable(true, true, true, true);
	gpu_set_alphatestenable(false);
	
	gpu_set_stencil_ref(mask);
	gpu_set_stencil_read_mask(mask);
	gpu_set_stencil_pass(stencilop_keep);
	gpu_set_stencil_func(cmpfunc_equal);
}

function stencil_reset(){
	if (topMask == 0) gpu_set_stencil_enable(false);
	else {
		gpu_set_stencil_ref(topMask);
		gpu_set_stencil_read_mask(topMask);
	}
}
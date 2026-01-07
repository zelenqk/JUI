function stencil_prepare_mask(){
	draw_clear_stencil(0);
	
	gpu_set_stencil_enable(true);
	gpu_set_stencil_write_mask(1);
	gpu_set_stencil_ref(1);
	gpu_set_stencil_func(cmpfunc_always);
	gpu_set_stencil_pass(stencilop_replace);
	
	// Write mask only where alpha > 0.5
	gpu_set_colorwriteenable(false, false, false, false);
}	

function finish_mask(){
	gpu_set_colorwriteenable(true, true, true, true);
	
	// Draw only where stencil == 1
	gpu_set_stencil_write_mask(0);
	gpu_set_stencil_read_mask(1);
	gpu_set_stencil_func(cmpfunc_equal);
	gpu_set_stencil_pass(stencilop_keep);
}

function stencil_reset(){
	gpu_set_stencil_enable(false);
}

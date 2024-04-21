global.clickable_hovered = noone;

if (global.updateable != undefined) {
	// use different reference so we can change global.updateable in update or draw
	var updateable = global.updateable;
	updateable.update();
	clickables_draw();
	if (variable_struct_exists(updateable, "draw"))	updateable.draw();
} else {
	clickables_update();
	clickables_draw();
}

with (obj_clickable) {
	if (global.clickable_hovered == id) {
		shader_set(sh_hovered);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
		shader_reset();
	}
}

global.darkness_surface = surface_create(display_get_gui_width(), display_get_gui_height());
global.flashlight_on = false;

function darkness() {
	if (!surface_exists(global.darkness_surface)) {
		global.darkness_surface = surface_create(display_get_gui_width(), display_get_gui_height());
	}
	surface_resize(global.darkness_surface, display_get_gui_width(), display_get_gui_height());
	surface_set_target(global.darkness_surface);
	draw_clear_alpha(c_black, 1);

	gpu_set_blendmode(bm_subtract);

	draw_set_alpha(1);
	if (global.flashlight_on) draw_circle(mouse_x, mouse_y, 400, false);

	draw_sprite(spr_fank_head_light, 0, 0, 0);

	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_set_alpha(1);
	draw_surface(global.darkness_surface, 0, 0);
}

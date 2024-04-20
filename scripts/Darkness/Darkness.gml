
global.darkness_surface = surface_create(display_get_gui_width(), display_get_gui_height());

function darkness(darkness_alpha=1, circle_radius=100) {
	if (!surface_exists(global.darkness_surface)) {
		global.darkness_surface = surface_create(display_get_gui_width(), display_get_gui_height());
	}
	surface_resize(global.darkness_surface, display_get_gui_width(), display_get_gui_height());
	surface_set_target(global.darkness_surface);
	draw_clear_alpha(c_black, darkness_alpha);

	gpu_set_blendmode(bm_subtract);

	draw_set_alpha(0.7);
	draw_circle(mouse_x, mouse_y, circle_radius, false);

	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_set_alpha(1);
	draw_surface(global.darkness_surface, 0, 0);
}

width = 4800;
height = 2700;
multiplier = 1/2;
setup = function() {
	view_enabled = true;
	view_visible[0] = true;
	camera_set_view_size(view_camera[0], width, height);
	window_set_size(width * multiplier, height * multiplier);
	surface_resize(application_surface, width * multiplier, height * multiplier);
	display_set_gui_size(width, height);
}
setup();
window_center();

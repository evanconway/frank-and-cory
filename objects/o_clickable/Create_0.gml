image_speed = 0;

pre_draw = function() {
	// default does nothing
};

draw = function() {
	draw_self();
};

on_click = function() {
	show_debug_message($"instance {id} clicked");
};

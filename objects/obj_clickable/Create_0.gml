image_speed = 0;

disabled = false; // object cannot be hovered or clicked

pre_draw = function() {
	// default does nothing
};

draw = function() {
	image_index = 0;
	draw_self();
};

on_click = function() {
	show_debug_message($"instance {id} clicked");
};

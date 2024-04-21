image_speed = 0;

disabled = false; // object cannot be hovered or clicked

pre_draw = function() {
	// default does nothing
};

draw = function() {
	if (visible) draw_self();
	image_index = 0;
	visible = true;
};

on_click = function() {
	show_debug_message($"instance {id} clicked");
};

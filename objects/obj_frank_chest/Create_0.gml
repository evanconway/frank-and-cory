event_inherited();

draw = function() {
	if (global.frank_attached_head) {
		image_index = 1;
		draw_self();
		frank_draw_expression();
	} else {
		image_index = 0;
		draw_self();
	}
};

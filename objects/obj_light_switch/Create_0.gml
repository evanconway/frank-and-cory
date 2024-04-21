event_inherited();

disabled = true;

draw = function() {
	image_index = 0;
	if (global.light_switch_on) image_index = 1;
	draw_self();
};

// on_click
// Since this object is only used for the intro sequence, all logic is defined there.

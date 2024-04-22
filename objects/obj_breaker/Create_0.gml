event_inherited();

disabled = true;

original_draw = draw;

draw = function() {
	image_index = 0;
	if (global.breaker_open) image_index = 1;
	if (global.light_switch_on) image_index = 2;
	original_draw();
};

// on_click
// Since this object is only used for the intro sequence, all logic is defined there.

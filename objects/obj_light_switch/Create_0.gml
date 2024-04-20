event_inherited();

disabled = true;

draw = function() {
	image_index = 0;
	if (global.light_switch_on) image_index = 1;
	draw_self();
};

event_inherited();

pre_draw = function() {
	if (global.light_switch_on) image_index = 1;
	else image_index = 0;
};

on_click = function() {
	global.light_switch_on = !global.light_switch_on;
};

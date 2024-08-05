event_inherited();

on_click = function() {
	global.updateable = dialog_get_updateable([
		cory_get_dialog_step("We shouldn't poke without asking."),
	]);
}

draw = function() {
	image_index = global.spider_pose;
	draw_set_alpha(1);
	draw_self();
}

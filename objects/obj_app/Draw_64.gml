if (keyboard_check_pressed(ord("1"))) {
	global.updateable = undefined;
	room_goto(rm_workshop);
}

if (keyboard_check_pressed(ord("2"))) {
	podcast_machine_transition();
}

global.clickable_hovered = noone;

// maintain updateable reference so we can change global.updateable in update or draw
var updateable = global.updateable;

if (updateable != undefined) {
	updateable.update();
	clickables_draw();
	if (variable_struct_exists(updateable, "draw"))	updateable.draw();
} else {
	clickables_update();
	clickables_draw();
}

draw_set_alpha(1);
window_set_cursor(cr_default);
if (global.chip_cursor) {
	window_set_cursor(cr_none);
	draw_sprite(spr_chips_cursor, 0, mouse_x, mouse_y);
}

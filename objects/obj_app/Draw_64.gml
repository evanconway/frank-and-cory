if (keyboard_check_pressed(ord("1"))) {
	audio_stop_all();
	global.updateable = undefined;
	room_goto(rm_workshop);
}

if (keyboard_check_pressed(ord("2"))) {
	audio_stop_all();
	podcast_machine_transition();
}

if (keyboard_check_pressed(ord("3"))) {
	audio_stop_all();
	complete_story();
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
if (global.chip_cursor) {
	draw_sprite(spr_chips_cursor, 0, mouse_x, mouse_y);
} else if (global.key_cursor) {
	draw_sprite(spr_key, 0, mouse_x, mouse_y);
} else if (global.memory_cursor) {
	draw_sprite(spr_memory_chip, 0, mouse_x, mouse_y);
} else {
	draw_sprite(spr_cursor, 0, mouse_x, mouse_y);
}

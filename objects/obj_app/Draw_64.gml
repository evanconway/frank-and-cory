if (keyboard_check_pressed(ord("1"))) {
	audio_stop_all();
	global.updateable = undefined;
	room_goto(rm_workshop);
}

if (keyboard_check_pressed(ord("2"))) {
	audio_stop_all();
	global.updateable = {
		step: 0,
		steps: [
			function() {
				room_goto(rm_podcast_machine);
				audio_group_load(audiogroup_story_machine);
				step += 1;
			},
			function() {
				if (room == rm_podcast_machine && audio_group_is_loaded(audiogroup_story_machine)) {
					podcast_maker_setup();
					global.cory_dialog_position = CORY_DIALOG_POSITION.PODCAST;
					global.frank_dialog_position = FRANK_DIALOG_POSITION.PODCAST;
					global.updateable = undefined;
					audio_group_unload(audiogroup_intro);
					audio_group_unload(audiogroup_workshop);
					audio_group_unload(audiogroup_finale);
				}
			},
		],
		update: function() {
			steps[step]();
		},
		draw: function() {},
	}
}

if (keyboard_check_pressed(ord("3"))) {
	audio_stop_all();
	global.updateable = {
		step: 0,
		steps: [
			function() {
				room_goto(rm_podcast_machine);
				step += 1;
			},
			function() {
				if (room == rm_podcast_machine) complete_story();
			},
		],
		update: function() {
			steps[step]();
		},
		draw: function() {},
	}
}

if (keyboard_check_pressed(ord("4"))) {
	audio_stop_all();
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
if (global.chip_cursor) {
	draw_sprite(spr_chips_cursor, 0, mouse_x, mouse_y);
} else if (global.key_cursor) {
	draw_sprite(spr_key, 0, mouse_x, mouse_y);
} else if (global.memory_cursor) {
	draw_sprite(spr_memory_chip, 0, mouse_x, mouse_y);
} else {
	draw_sprite(spr_cursor, 0, mouse_x, mouse_y);
}

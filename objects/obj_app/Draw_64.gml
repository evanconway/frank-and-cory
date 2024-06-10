if (keyboard_check_pressed(ord("1"))) {
	global.updateable = undefined;
	room_goto(rm_workshop);
}

if (keyboard_check_pressed(ord("2"))) {
	global.updateable = undefined;
	room_goto(rm_test_storymaker);
}

if (keyboard_check_pressed(ord("3"))) {
	if (global.updateable != global.podcast_updateable) {
		global.updateable = global.podcast_updateable;
		with (obj_podcast_clickable) {
			visible = true;
			disabled = false;
		}
	} else {
		global.updateable = undefined;
		with (obj_podcast_clickable) {
			visible = false;
			disabled = true;
		}
	}
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

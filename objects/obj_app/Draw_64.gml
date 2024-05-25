if keyboard_check_pressed(ord("1")) {
	global.updateable = undefined;
	room_goto(rm_workshop);
}

if keyboard_check_pressed(ord("2")) {
	global.updateable = undefined;
	room_goto(rm_test_storymaker);
}

global.clickable_hovered = noone;

// use different reference so we can change global.updateable in update or draw
	var updateable = global.updateable;

if (updateable != undefined) {
	updateable.update();
	clickables_draw();
	if (variable_struct_exists(updateable, "draw"))	updateable.draw();
} else {
	clickables_update();
	clickables_draw();
}

// start with dark room
global.updateable = {
	update: function() {
		global.clickable_hovered = noone;
		with (obj_light_switch) {
			if (position_meeting(mouse_x, mouse_y, id)) global.clickable_hovered = id;
			if (mouse_check_button_pressed(mb_any) && global.clickable_hovered == id) {
				global.light_switch_on = true;
				global.updateable = undefined;
			}
		}
	},
	draw: function() {
		clickables_draw();
		if (!global.light_switch_on) darkness(1, 400);
	}
}

room_goto(rm_workshop);

/*
event_inherited();

pre_draw = function() {
	if (global.light_switch_on) image_index = 1;
	else image_index = 0;
};

on_click = function() {
	global.light_switch_on = !global.light_switch_on;
};

*/
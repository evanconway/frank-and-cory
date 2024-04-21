// start with dark room
global.updateable = {
	update: function() {
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
		draw_set_alpha(0.4); // extra darkness
		draw_set_color(c_black);
		draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		if (!global.light_switch_on) darkness(1, 400);
	}
}

room_goto(rm_workshop);

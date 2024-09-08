function reset_game() {
	global.cory_light_alpha = 0;
	global.flashlight_on = false;
	global.cory_dialog_position = CORY_DIALOG_POSITION.INTRO_BREAKER;
	global.frank_dialog_position = FRANK_DIALOG_POSITION.INTRO_HEAD;
	global.frank_expression = FRANK_EXPRESSION.BLANK;
	global.frank_idle_expression = FRANK_EXPRESSION.NEUTRAL;
	global.frank_idle_expression_time = 80;
	global.chip_taken = false;
	global.chip_cursor = false;
	global.key_cursor = false;
	global.memory_cursor = false;
	global.frank_memory_chip_added = false;
	global.frank_attached_arms = false;
	global.frank_attached_head = false;
	global.frank_attached_legs = false;
	global.light_switch_on = false;
	global.intro_blackout_alpha = 1;
	global.breaker_open = false;
	
	ds_map_clear(global.draggable_position_map);
	ds_map_clear(global.position_draggable_map);
	
	room_goto(rm_workshop);
	global.updateable = {
		update: function() {
			if (room == rm_workshop) {
				start_intro();
			}
		},
		draw: function() {
			draw_set_alpha(1);
			draw_set_color(c_black);
			draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
		},
	};
}

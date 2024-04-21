// initial sequence
global.updateable = {
	update: function() {
		if (room != rm_workshop) return;
		global.clickable_blackout_alpha = 1;
		updateable_start_dialog([
			"Huh? Oh. Where am I? Oh. I must have fallen asleep.",
			"Frank!",
			"Huh?",
			"Are you alright?",
			"Where's that voice coming from?",
			"Frank! Over here!",
			"Who's Frank?",
			"Geez, that power outage must have really knocked you out good.",
			"Why can't I feel my arms?",
			"One sec, I'm looking for the breaker box."
		], {
			update: function() {
				global.clickable_blackout_alpha -= 0.01;
				if (global.clickable_blackout_alpha > 0) return;
				global.clickable_blackout_alpha = 0;
				updateable_start_dialog([
					"Ah! My body! What happened to me?",
					"Geez, this place could use some spring cleaning, don't you think?",
					"Am I dying? Am I dead? Is this death?",
					"You're going to be okay. Just in a little shock is all. Heh. Get it?",
					"I don't.",
					"Do you remember anything before the outage?",
					"I don't even know who you are.",
					"Huh?"
					// CORY inspects the robot head.
				]);
			}
		});
	},
}

/*
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
*/

room_goto(rm_workshop);

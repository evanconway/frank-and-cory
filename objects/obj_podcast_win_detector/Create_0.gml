event_inherited();

pre_update = function() {
	// win condition
	if (room != rm_podcast_machine) return;
	var complete = podcast_get_is_complete();
	if (complete) {
		global.updateable = {
			alpha: 0.6,
			step: 0,
			steps: [
				function() {
					play_sfx(snd_win_achieved);
					step += 1;
				},
				function() {},
			],
			update: function() {
				steps[step]();
			},
			draw: function() {
				draw_set_alpha(alpha);
				draw_set_color(c_white);
				draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
			},
		};
		global.updateable = dialog_get_updateable([
			frank_get_dialog_step("Why...", FRANK_EXPRESSION.PODCAST_LEFT_UP),
			frank_get_dialog_step("I think we've got it!", FRANK_EXPRESSION.PODCAST_BLANK_PUMP),
			cory_get_dialog_step("Ooh!", CORY_EXPRESSION.PODCAST_WINGS),
			cory_get_dialog_step("Let's see it on the screen!", CORY_EXPRESSION.PODCAST_HIP),
		], {
			after_dialog_updateable: {
				update: complete_story,
			},
		});
	}
};

disabled = true;
draw = function() {}; // invisible

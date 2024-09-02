event_inherited();

pre_update = function() {
	// win condition
	if (room != rm_podcast_machine) return;
	var complete = podcast_get_is_complete();
	if (complete) {
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

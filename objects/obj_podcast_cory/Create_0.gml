event_inherited();

clicks = 0;

on_click = function() {
	if (podcast_get_is_complete()) return;
	if (clicks == 0) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Not quite right yet.", CORY_EXPRESSION.PODCAST_WINGS),
		]);
	} else if (clicks == 1) {
		global.updateable = dialog_get_updateable([
			cory_get_dialog_step("Remember there are voice, sound effects and music reels.", CORY_EXPRESSION.PODCAST_WINGS),
			cory_get_dialog_step("Pay attention to the start and end of each reel.", CORY_EXPRESSION.PODCAST_HIP),
			cory_get_dialog_step("If you can match starts to ends,", CORY_EXPRESSION.PODCAST_NEUTRAL),
			cory_get_dialog_step("you'll have this together in no time!", CORY_EXPRESSION.PODCAST_WINGS),
		]);
	}
	clicks += 1;
	if (clicks >= 2) clicks = 0;
};

original_draw = draw;

draw = function() {
	cory_set_expression()
	// I don't remember why we have this?
	var original_image_index = image_index;
	original_draw();
	image_index = original_image_index;
};
